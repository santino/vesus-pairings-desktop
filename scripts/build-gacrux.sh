#!/usr/bin/env bash
#
# build-gacrux.sh
# Builds Gacrux engine binaries using PyInstaller.
#
# Usage:
#   ./build-gacrux.sh --output-dir <directory>
#
# Outputs binaries, checksums, and version info to the specified directory.

set -euo pipefail

# Configuration
readonly REPO_URL="https://github.com/OttoMilvang/TieBreakServer.git"
readonly REPO_BRANCH="${REPO_BRANCH:-main}"

# Stdlib modules trimmed from the bundle to keep it small.
# NOTE: matplotlib/scipy pull in pyparsing, which imports unittest/doctest at
# runtime, so the ratingsimulation build must use the reduced set below.
readonly DEFAULT_EXCLUDES="tkinter tkinter.ttk idlelib turtledemo unittest test doctest pydoc ensurepip curses lib2to3 multiprocessing asyncio"
readonly PLOTTING_EXCLUDES="tkinter tkinter.ttk idlelib turtledemo lib2to3 multiprocessing asyncio"

# Global variables set by main
ENGINE_DIR=""
TEMP_DIR=""
REPO_DIR=""
LOG_FILE=""

# Logging helpers
log() {
  local level="$1"
  shift
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [$level] $*" | tee -a "$LOG_FILE"
}

log_info() { log "INFO" "$@"; }
log_warn() { log "WARN" "$@"; }
log_error() { log "ERROR" "$@"; }

# Returns 0 when running on Windows (Git Bash / MSYS / Cygwin), 1 otherwise.
# Uses uname -s for reliability across Git Bash variants and falls back to
# the PLATFORM env var set by the CI workflow.
is_windows() {
  case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*|Windows*) return 0 ;;
  esac
  case "${OSTYPE:-}" in
    msys*|mingw*|cygwin*|win32*) return 0 ;;
  esac
  [[ "${PLATFORM:-}" == windows-* ]] && return 0
  return 1
}

# Returns the platform suffix (e.g., linux-x64, windows-arm64)
get_platform_suffix() {
  if [[ -n "${PLATFORM:-}" ]]; then
    echo "$PLATFORM"
    return
  fi

  local platform_os=""
  local platform_arch=""

  case "$(uname -s)" in
    Linux*) platform_os="linux" ;;
    Darwin*) platform_os="macos" ;;
    MINGW*|MSYS*|CYGWIN*|Windows*) platform_os="windows" ;;
  esac

  case "$(uname -m)" in
    x86_64|x64) platform_arch="x64" ;;
    aarch64|arm64) platform_arch="arm64" ;;
  esac

  echo "${platform_os}-${platform_arch}"
}

# Cleanup handler to remove temporary files and handle logs
cleanup() {
  local exit_code="${1:-$?}"

  echo "Cleaning up temporary files..."

  if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" && "$TEMP_DIR" != "/" ]]; then
    rm -rf "$TEMP_DIR"
    echo "  - Removed temp directory: $TEMP_DIR"
  fi

  if [[ -n "$REPO_DIR" && -d "$REPO_DIR/build" ]]; then
    rm -rf "$REPO_DIR/build"
  fi

  if [[ -n "$REPO_DIR" && -d "$REPO_DIR" ]]; then
    find "$REPO_DIR" -maxdepth 1 -name "*.spec" -delete 2>/dev/null || true
  fi

  if [[ -n "$LOG_FILE" ]] && [[ -f "$LOG_FILE" ]]; then
    if [[ "$exit_code" -eq 0 ]]; then
      rm -f "$LOG_FILE"
      echo "  - Removed build log (build succeeded)"
    else
      echo "Build log preserved at: $LOG_FILE"
    fi
  fi

  echo "Cleanup completed"
}

validate_prerequisites() {
  log_info "Validating prerequisites..."

  if [[ -z "$ENGINE_DIR" ]]; then
    log_error "Output directory not specified. Use --output-dir"
    exit 1
  fi

  if [[ ! -w "$ENGINE_DIR" ]]; then
    mkdir -p "$ENGINE_DIR" 2>/dev/null || {
      log_error "Engine directory is not writable: $ENGINE_DIR"
      exit 1
    }
  fi

  if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    log_error "Python not found. Please install Python 3.11+"
    exit 1
  fi
}

setup_environment() {
  log_info "Setting up build environment..."
  mkdir -p "$ENGINE_DIR"
  mkdir -p "$TEMP_DIR"
  log_info "Output directory: $ENGINE_DIR"
  log_info "Temp directory: $TEMP_DIR"
}

sync_repository() {
  log_info "Syncing repository..."

  if [[ -d "$REPO_DIR/.git" ]]; then
    log_info "Updating existing repository..."
    cd "$REPO_DIR"
    git fetch origin "$REPO_BRANCH"
    git checkout "$REPO_BRANCH"
    git reset --hard "origin/$REPO_BRANCH"
  else
    log_info "Cloning repository..."
    git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$REPO_DIR"
  fi

  log_info "Repository synced successfully"
}

detect_version() {
  local platform_suffix
  platform_suffix=$(get_platform_suffix)

  # The version module lives inside the package since the gacrux/ refactor.
  local version_module=""
  if [[ -f "$REPO_DIR/gacrux/version.py" ]]; then
    version_module="gacrux.version"
  elif [[ -f "$REPO_DIR/version.py" ]]; then
    version_module="version"
  fi

  if [[ -n "$version_module" ]]; then
    log_info "Detecting version from $version_module..."
    export PYI_REPO_DIR="$REPO_DIR"
    export PYI_VERSION_MODULE="$version_module"

    local python_cmd="python3"
    if ! command -v python3 &> /dev/null; then
      python_cmd="python"
    fi

    local version
    version=$($python_cmd << 'PYTHON_SCRIPT'
import sys
import os
repo_dir = os.environ.get('PYI_REPO_DIR', '')
module = os.environ.get('PYI_VERSION_MODULE', '')
if repo_dir and module:
    sys.path.insert(0, repo_dir)
    try:
        mod = __import__(module, fromlist=['version'])
        if callable(getattr(mod, 'version', None)):
            print(mod.version()['version'])
        else:
            print(mod.__version__)
    except Exception:
        pass
PYTHON_SCRIPT
    )

    if [[ -n "$version" ]]; then
      echo "$version" > "$ENGINE_DIR/version-$platform_suffix.txt"
      log_info "Detected Gacrux version: $version"
      return 0
    fi

    log_warn "Could not import $version_module for version detection."
  fi

  if [[ -d "$REPO_DIR/.git" ]]; then
    # The clone is shallow, so tags are only present if fetched explicitly.
    (cd "$REPO_DIR" && git fetch --tags --depth 1 origin >/dev/null 2>&1) || true
    local git_version
    git_version=$(cd "$REPO_DIR" && git describe --tags --abbrev=0 2>/dev/null || echo "")
    if [[ -n "$git_version" ]]; then
      echo "$git_version" > "$ENGINE_DIR/version-$platform_suffix.txt"
      log_info "Detected Gacrux version from git: $git_version"
      return 0
    fi
  fi

  # Publishing an unversioned release is worse than failing the build.
  log_error "Could not determine Gacrux version (no version module and no git tags)."
  exit 1
}

build_binary() {
  local source_file="$1"
  local binary_name="$2"
  local extra_pip="${3:-}"
  local extra_hidden="${4:-}"
  local excludes="${5:-$DEFAULT_EXCLUDES}"

  log_info "Building $binary_name..."

  local venv_dir="$TEMP_DIR/venv"
  log_info "Creating virtual environment at $venv_dir..."

  local python_cmd="python3"
  if ! command -v python3 &> /dev/null; then
    python_cmd="python"
  fi
  $python_cmd -m venv "$venv_dir"

  if [[ ! -d "$venv_dir" ]]; then
    log_error "Failed to create venv at $venv_dir"
    exit 1
  fi

  local venv_python
  if is_windows; then
    if [[ -f "$venv_dir/Scripts/python.exe" ]]; then
      venv_python="$venv_dir/Scripts/python.exe"
    elif [[ -f "$venv_dir/Scripts/python3.exe" ]]; then
      venv_python="$venv_dir/Scripts/python3.exe"
    else
      log_error "No Python executable found in $venv_dir/Scripts/"
      exit 1
    fi
  else
    venv_python="$venv_dir/bin/python"
  fi

  log_info "Using venv Python: $venv_python"

  log_info "Installing PyInstaller in virtual environment..."
  "$venv_python" -m pip install --quiet pyinstaller networkx

  if [[ -n "$extra_pip" ]]; then
    log_info "Installing extra dependencies for $binary_name: $extra_pip"
    "$venv_python" -m pip install --quiet $extra_pip
  fi

  cd "$REPO_DIR"

  if [[ -f "requirements.txt" ]]; then
    log_info "Installing requirements..."
    "$venv_python" -m pip install --quiet -r requirements.txt 2>/dev/null || "$venv_python" -m pip install --quiet networkx
  fi

  # Strip debug symbols from the base Python installation to reduce binary size on Linux.
  if [[ "$(uname -s)" == "Linux" ]]; then
    log_info "Detecting Python base installation path..."
    local python_base_prefix
    python_base_prefix=$("$venv_python" -c "import sys; print(sys.base_prefix)")

    if [[ -d "$python_base_prefix/lib" ]]; then
      log_info "Stripping libraries in $python_base_prefix/lib ..."
      find "$python_base_prefix/lib" -name "*.so" -type f -exec strip --strip-unneeded {} \; 2>/dev/null || true
      find "$python_base_prefix/lib" -name "libpython*.so*" -type f -exec strip --strip-unneeded {} \; 2>/dev/null || true
      log_info "Stripping complete."
    else
      log_warn "Could not find lib directory in base prefix."
    fi
  fi

  # The engines live in the gacrux/ package but import their siblings flat when
  # executed as a script, so both the repo root and the package dir are needed.
  local repo_dir_for_python="$REPO_DIR"
  local gacrux_dir_for_python="$REPO_DIR/gacrux"
  local engine_dir_for_python="$ENGINE_DIR"
  local source_file_for_python="$source_file"
  if is_windows; then
    repo_dir_for_python=$(cygpath -m "$REPO_DIR" 2>/dev/null || echo "$REPO_DIR")
    gacrux_dir_for_python=$(cygpath -m "$REPO_DIR/gacrux" 2>/dev/null || echo "$REPO_DIR/gacrux")
    engine_dir_for_python=$(cygpath -m "$ENGINE_DIR" 2>/dev/null || echo "$ENGINE_DIR")
    source_file_for_python=$(cygpath -m "$REPO_DIR/$source_file" 2>/dev/null || echo "$REPO_DIR/$source_file")
  fi

  log_info "Running PyInstaller..."
  local pyi_extra=""
  if [[ -n "$extra_hidden" ]]; then
    for hi in $extra_hidden; do
      pyi_extra="$pyi_extra --hidden-import $hi"
    done
  fi
  local pyi_exclude=""
  for ex in $excludes; do
    pyi_exclude="$pyi_exclude --exclude-module $ex"
  done
  # shellcheck disable=SC2086
  "$venv_python" -m PyInstaller --onedir --noconfirm \
    --name "$binary_name" \
    --distpath "$engine_dir_for_python" \
    --paths "$repo_dir_for_python" \
    --paths "$gacrux_dir_for_python" \
    --hidden-import networkx \
    $pyi_extra \
    $pyi_exclude \
    "$source_file_for_python"

  local exe_path="$ENGINE_DIR/$binary_name/$binary_name"
  if is_windows; then
    exe_path="${exe_path}.exe"
  fi

  if [[ -f "$exe_path" ]]; then
    chmod 755 "$exe_path"

    if [[ "$(uname -s)" == "Darwin" ]]; then
      log_info "Ad-hoc signing binary for macOS..."
      codesign --force --deep -s - "$exe_path" 2>/dev/null || log_warn "Codesign failed - binary may trigger Gatekeeper warning"
    fi

    log_info "Packaging onedir bundle into a platform-native archive..."
    local platform_suffix
    platform_suffix=$(get_platform_suffix)
    # Archive contents are stored relative to the bundle directory so the
    # executable and _internal/ sit at the archive root (no nested folder).
    GACREXE_NAME="$binary_name" GACREXE_DIR="$ENGINE_DIR" GACREXE_SUFFIX="$platform_suffix" "$venv_python" - <<'PYEOF'
import os
name = os.environ["GACREXE_NAME"]
engine_dir = os.environ["GACREXE_DIR"]
suffix = os.environ.get("GACREXE_SUFFIX", "")
is_windows = suffix.startswith("windows")
src = os.path.join(engine_dir, name)
arc_base = name + "-" + suffix
if is_windows:
    import zipfile
    arc = os.path.join(engine_dir, arc_base + ".zip")
    with zipfile.ZipFile(arc, "w", zipfile.ZIP_DEFLATED) as zf:
        for root, _d, files in os.walk(src):
            for f in files:
                fp = os.path.join(root, f)
                zf.write(fp, os.path.relpath(fp, src))
else:
    import tarfile
    arc = os.path.join(engine_dir, arc_base + ".tar.gz")
    with tarfile.open(arc, "w:gz") as tf:
        for item in sorted(os.listdir(src)):
            tf.add(os.path.join(src, item), arcname=item, recursive=True)
print("Created archive:", arc)
PYEOF

    log_info "$binary_name built and packaged successfully"

    # The archive is a faithful copy of the onedir staging directory, so drop
    # the staging copy to avoid uploading every engine twice as an artifact.
    local archive_name="$binary_name-$platform_suffix"
    if [[ "$platform_suffix" == windows* ]]; then
      archive_name="${archive_name}.zip"
    else
      archive_name="${archive_name}.tar.gz"
    fi
    if [[ -f "$ENGINE_DIR/$archive_name" ]]; then
      rm -rf "$ENGINE_DIR/$binary_name"
      log_info "Removed staging directory: $binary_name"
    fi
  else
    log_error "Build failed for $binary_name (expected executable at $exe_path)"
    exit 1
  fi
}

build_all_binaries() {
  log_info "Building all binaries..."

  local platform_suffix
  platform_suffix=$(get_platform_suffix)

  build_binary "gacrux/pairingchecker.py" "pairingchecker"
  build_binary "gacrux/tournamentgenerator.py" "tournamentgenerator"
  build_binary "gacrux/tiebreakchecker.py" "tiebreakchecker"
  # secrets: imported by numpy>=2 inside its compiled bit_generator extension,
  # so PyInstaller's static analysis cannot see it.
  build_binary "gacrux/ratingsimulation.py" "ratingsimulation" "matplotlib numpy scipy" "matplotlib numpy scipy matplotlib.backends.backend_agg secrets" "$PLOTTING_EXCLUDES"

  log_info "All binaries built successfully"
}

generate_checksums() {
  log_info "Generating checksums..."

  local platform_suffix
  platform_suffix=$(get_platform_suffix)
  local checksum_file="$ENGINE_DIR/checksums-$platform_suffix.txt"

  for binary in "$ENGINE_DIR"/*; do
    if [[ -f "$binary" ]]; then
      local binary_name
      binary_name=$(basename "$binary")
      if [[ "$binary_name" == "build.log" ]] || [[ "$binary_name" == version-* ]]; then
        continue
      fi
      local checksum
      checksum=$(sha256sum "$binary" | awk '{print $1}')
      echo "$checksum  $binary_name" >> "$checksum_file"
      log_info "  Added checksum: $binary_name"
    fi
  done

  log_info "Checksums generated: $checksum_file"
}

print_usage() {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --output-dir DIR    Output directory for binaries (REQUIRED)"
  echo "  --help              Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 --output-dir ./engines"
}

main() {
  trap 'cleanup $?' EXIT

  local output_dir=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --output-dir)
        output_dir="$2"
        shift 2
        ;;
      --help|-h)
        print_usage
        exit 0
        ;;
      *)
        echo "ERROR: Unknown option: $1"
        print_usage
        exit 1
        ;;
    esac
  done

  if [[ -z "$output_dir" ]]; then
    echo "ERROR: --output-dir is required"
    echo ""
    print_usage
    exit 1
  fi

  if [[ "$output_dir" != /* ]]; then
    output_dir="$(cd "$(dirname "$output_dir")" 2>/dev/null && pwd)/$(basename "$output_dir")" 2>/dev/null || output_dir="$(pwd)/$output_dir"
  fi

  ENGINE_DIR="$output_dir"
  TEMP_DIR="$ENGINE_DIR/temp"
  REPO_DIR="$TEMP_DIR/TieBreakServer"
  LOG_FILE="$ENGINE_DIR/build.log"

  mkdir -p "$ENGINE_DIR"

  log_info "=== Starting Gacrux binary build ==="

  validate_prerequisites
  setup_environment
  sync_repository
  detect_version
  build_all_binaries
  generate_checksums

  log_info "=== Build completed successfully ==="
  log_info "Output directory: $ENGINE_DIR"
}

main "$@"

# Building Gacrux Engines

This guide explains how to build the Gacrux engine binaries locally using the simplified build script.

## Prerequisites

- Python 3.11 or higher
- Git
- PyInstaller (automatically installed during build)

## Quick Start

### Build for Current Platform

```bash
# Make the script executable
chmod +x scripts/build-gacrux.sh

# Build (binaries are built for the current platform only)
./scripts/build-gacrux.sh --output-dir ./engines
```

## Build Process

The build script performs the following steps:

1. **Clones the Gacrux repository** from [TieBreakServer](https://github.com/OttoMilvang/TieBreakServer)
2. **Detects the version** from `version.py`
3. **Creates a Python virtual environment**
4. **Installs PyInstaller and dependencies**
5. **Builds all four binaries** as PyInstaller *onedir* bundles:
   - `pairingchecker`
   - `tournamentgenerator`
   - `tiebreakchecker`
   - `ratingsimulation`
6. **Packages each bundle** into a platform-native archive (`.zip` on Windows, `.tar.gz` on macOS/Linux), preserving the executable bit
7. **Generates SHA256 checksums** for the archives
8. **Automatically cleans up** temporary files

## Output

After a successful build, the output directory contains the *onedir* bundles and their archives:

```
engines/
├── pairingchecker/                         # onedir bundle (executable + _internal/)
│   ├── pairingchecker[.exe]
│   └── _internal/
├── tournamentgenerator/
├── tiebreakchecker/
├── ratingsimulation/
├── pairingchecker-<platform>.tar.gz        # .zip on Windows
├── tournamentgenerator-<platform>.tar.gz
├── tiebreakchecker-<platform>.tar.gz
├── ratingsimulation-<platform>.tar.gz
├── checksums-<platform>.txt                # SHA256 checksums (of the archives)
└── version-<platform>.txt                  # Gacrux version
```

`<platform>` is e.g. `linux-x64`, `macos-arm64`, or `windows-x64`. The archives are what get published to GitHub Releases; the built bundle folders are for local testing.

## Troubleshooting

### Python Not Found

```
ERROR: Python not found. Please install Python 3.11+
```

**Solution:** Install Python 3.11 or higher from [python.org](https://www.python.org/downloads/)

### Permission Denied

```
ERROR: Engine directory is not writable: ./engines
```

**Solution:** Ensure you have write permissions to the output directory or specify a different directory.

### Build Failed

Check the build log at `engines/build.log` for detailed error messages.

## Verification

After building, verify the binaries:

```bash
# Check bundle and archive sizes
ls -lh engines/

# Verify checksums — run from inside the output dir, since the file lists bare
# archive names (substitute your platform suffix: linux-x64, macos-arm64, windows-x64, ...)
(cd engines && sha256sum -c checksums-linux-x64.txt)   # macOS: shasum -a 256 -c checksums-macos-arm64.txt

# Check version
cat engines/version-linux-x64.txt

# Test binaries (macOS/Linux)
./engines/pairingchecker/pairingchecker --help

# Test binaries (Windows)
engines\pairingchecker\pairingchecker.exe --help
```

## Support

For issues or questions:
- Check the build log: `engines/build.log`
- Verify prerequisites are met
- Ensure you have write permissions
- Check Python version (3.11+)

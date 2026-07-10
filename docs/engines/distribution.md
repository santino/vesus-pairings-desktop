# Gacrux Engines Distribution

Gacrux engine binaries are published as GitHub Releases, making them easily accessible to all chess enthusiasts.

## Available Binaries

Each engine is distributed as a **platform-native archive** that bundles the executable together with its `_internal` dependencies folder. This is a PyInstaller *onedir* build, which starts faster at runtime than a single self-extracting executable.

- **Windows:** `.zip` archives (e.g. `pairingchecker-windows-x64.zip`)
- **macOS / Linux:** `.tar.gz` archives (e.g. `pairingchecker-linux-x64.tar.gz`)

On macOS/Linux the executable bit is set before packaging and preserved inside the `.tar.gz`, so no `chmod` is needed after extraction.

Each release contains archives for all supported platforms:

| Platform      | pairingchecker | tournamentgenerator | tiebreakchecker | ratingsimulation |
|---------------|----------------|---------------------|-----------------|------------------|
| macOS ARM64   | ✓              | ✓                   | ✓               | ✓                |
| macOS x64     | ✓              | ✓                   | ✓               | ✓                |
| Linux ARM64   | ✓              | ✓                   | ✓               | ✓                |
| Linux x64     | ✓              | ✓                   | ✓               | ✓                |
| Windows ARM64 | ✓              | ✓                   | ✓               | ✓                |
| Windows x64   | ✓              | ✓                   | ✓               | ✓                |

### Binary Details

- **pairingchecker** - Generates and validates chess pairings (used by Vesus Pairings)
- **tournamentgenerator** - Generates random tournaments (used for FIDE endorsement)
- **tiebreakchecker** - Calculates tiebreaks and standings (available for chess operators)
- **ratingsimulation** - Simulates tournaments to study chess rating system behaviour (available for chess operators)

## Downloading Binaries

### From GitHub Releases

1. Go to the **Releases** tab in the repository
2. Find the latest release (e.g., `gacrux-v1.8.48`)
3. Download the archive for your platform and engine (e.g. `pairingchecker-linux-x64.tar.gz`)
4. See [checking binaries](#checking-binaries) to verify
5. Extract the archive (see [extracting archives](#extracting-archives))

### Using GitHub CLI

```bash
# Download all archives
gh release download gacrux-v1.8.48 --pattern "*"

# Download for specific platform (e.g., Linux x64)
gh release download gacrux-v1.8.48 --pattern "*-linux-x64.tar.gz"
```

### Using cURL

```bash
# Download a specific engine archive
curl -L https://github.com/santino/vesus-pairings-desktop/releases/download/gacrux-v1.8.48/pairingchecker-linux-x64.tar.gz -o pairingchecker-linux-x64.tar.gz
```

## Checking Binaries

Each release includes a `checksums.txt` file listing the SHA256 hash of every archive (checksums are computed over the **archive files**, not the extracted executables). Verify **before** extracting.

To verify a single archive, compute its hash and compare it with the matching line in `checksums.txt`:

```bash
# Linux
sha256sum pairingchecker-linux-x64.tar.gz

# macOS
shasum -a 256 pairingchecker-linux-x64.tar.gz
```

```powershell
# Windows (PowerShell)
Get-FileHash pairingchecker-windows-x64.zip -Algorithm SHA256
```

`checksums.txt` lists archives for **every** platform, so `sha256sum -c checksums.txt` would report the archives you did not download as failures. To check only the files present in the current directory (GNU coreutils):

```bash
sha256sum --ignore-missing -c checksums.txt
```

Alternatively, use the bundled helper, which looks up the right entry for you:

```bash
./scripts/verify-checksum.sh pairingchecker-linux-x64.tar.gz checksums.txt
```

## Extracting Archives

Each archive holds the executable and its `_internal/` folder at the **root** (there is no wrapping folder inside the archive), so extract into a dedicated directory to keep things tidy.

### macOS / Linux (`.tar.gz`)

```bash
mkdir pairingchecker
tar -xzf pairingchecker-linux-x64.tar.gz -C pairingchecker
./pairingchecker/pairingchecker --help
```

### Windows (`.zip`)

```powershell
Expand-Archive pairingchecker-windows-x64.zip -DestinationPath pairingchecker
.\pairingchecker\pairingchecker.exe --help
```

After extracting into a `pairingchecker/` directory, the layout is:

```
pairingchecker/               # a directory you created for extraction
├── pairingchecker[.exe]      # the executable (already marked executable on macOS/Linux)
└── _internal/                # dependencies
```

The archive contents themselves are flat — the outer `pairingchecker/` folder above is just the extraction target you chose, not part of the archive. Keep the executable next to its `_internal` folder; the two must stay together for the engine to run.

## Release Contents

Each release includes:

```
gacrux-v1.8.48/
├── pairingchecker-macos-arm64.tar.gz
├── pairingchecker-macos-x64.tar.gz
├── pairingchecker-linux-arm64.tar.gz
├── pairingchecker-linux-x64.tar.gz
├── pairingchecker-windows-arm64.zip
├── pairingchecker-windows-x64.zip
├── tournamentgenerator-<platform>.<ext>   # all platforms
├── tiebreakchecker-<platform>.<ext>       # all platforms
├── ratingsimulation-<platform>.<ext>      # all platforms
├── checksums.txt                          # SHA256 checksums (of the archives)
└── version.txt                            # Gacrux version
```

Each archive contains the engine executable and an `_internal/` dependencies folder at its root (no wrapping folder), so extract each archive into its own directory.

## Platform-Specific Notes

### macOS

- Extracted executable has no file extension
- The executable is ad-hoc signed during the build; you may still need to allow it: `System Settings → Privacy & Security`

### Linux

- Extracted executable has no file extension
- The executable bit is preserved inside the `.tar.gz`, so no `chmod +x` is required after extracting

### Windows

- Extracted executable has a `.exe` extension
- No additional setup required

## Latest Version

Always download the latest version for:
- Best performance
- Latest chess tournament rules compliance
- Security fixes

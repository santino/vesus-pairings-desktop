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

Each release includes a `checksums.txt` file to verify integrity. Checksums are computed over the **archive files** (not the extracted executables):

```bash
# Verify all downloaded archives
sha256sum -c checksums.txt

# Verify a specific archive
sha256sum pairingchecker-linux-x64.tar.gz
```

Compare the output with the checksums in `checksums.txt`. Verify **before** extracting.

## Extracting Archives

### macOS / Linux (`.tar.gz`)

```bash
tar -xzf pairingchecker-linux-x64.tar.gz
# Produces a ./pairingchecker/ folder with the executable already marked executable
./pairingchecker/pairingchecker --help
```

### Windows (`.zip`)

```powershell
Expand-Archive pairingchecker-windows-x64.zip -DestinationPath .
# Produces a .\pairingchecker\ folder
.\pairingchecker\pairingchecker.exe --help
```

Keep the executable next to its `_internal` folder — the two must stay together for the engine to run.

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

Each archive expands to a folder named after the engine, containing the executable plus an `_internal/` dependencies folder.

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

# Gacrux Engines Distribution

Gacrux engine binaries are published as GitHub Releases, making them easily accessible to all chess enthusiasts.

## Available Binaries

Each release contains binaries for all supported platforms:

| Platform      | pairingchecker | tournamentgenerator | tiebreakchecker |
|---------------|---------------|----------------------|-----------------|
| macOS ARM64   | ✓             | ✓                    | ✓               |
| macOS x64     | ✓             | ✓                    | ✓               |
| Linux ARM64   | ✓             | ✓                    | ✓               |
| Linux x64     | ✓             | ✓                    | ✓               |
| Windows ARM64 | ✓             | ✓                    | ✓               |
| Windows x64   | ✓             | ✓                    | ✓               |

### Binary Details

- **pairingchecker** - Generates and validates chess pairings (used by Vesus Pairings)
- **tournamentgenerator** - Generates random tournaments (used for FIDE endorsement)
- **tiebreakchecker** - Calculates tiebreaks and standings (available for chess operators)

## Downloading Binaries

### From GitHub Releases

1. Go to the **Releases** tab in the repository
2. Find the latest release (e.g., `gacrux-v1.8.48`)
3. Download the binaries for your platform
4. See [checking binaries](#checking-binaries) to verify

### Using GitHub CLI

```bash
# Download all binaries
gh release download gacrux-v1.8.48 --pattern "*"

# Download for specific platform (e.g., Linux x64)
gh release download gacrux-v1.8.48 --pattern "*-linux-x64"
```

### Using cURL

```bash
# Download specific binary
curl -L https://github.com/santino/vesus-pairings-desktop/releases/download/gacrux-v1.8.48/pairingchecker -o pairingchecker
```

## Checking Binaries

Each release includes a `checksums.txt` file to verify integrity:

```bash
# Verify all binaries
sha256sum -c checksums.txt

# Verify specific binary
sha256sum pairingchecker
```

Compare the output with the checksums in `checksums.txt`.

## Release Contents

Each release includes:

```
gacrux-v1.8.48/
├── pairingchecker          # macOS/Linux
├── pairingchecker.exe      # Windows
├── tournamentgenerator     # macOS/Linux
├── tournamentgenerator.exe # Windows
├── tiebreakchecker         # macOS/Linux
├── tiebreakchecker.exe     # Windows
├── checksums.txt           # SHA256 checksums
└── version.txt             # Gacrux version
```

## Platform-Specific Notes

### macOS

- Binaries have no file extension
- May need to allow running unsigned apps: `System Preferences → Security & Privacy → General`

### Linux

- Binaries have no file extension
- Make executable: `chmod +x pairingchecker`

### Windows

- Binaries have `.exe` extension
- No additional setup required

## Latest Version

Always download the latest version for:
- Best performance
- Latest chess tournament rules compliance
- Security fixes

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
5. **Builds all three binaries**:
   - `pairingchecker`
   - `tournamentgenerator`
   - `tiebreakchecker`
6. **Generates SHA256 checksums** for all binaries
7. **Automatically cleans up** temporary files

## Output

After a successful build, the output directory contains:

```
engines/
├── pairingchecker              # macOS/Linux (no extension)
├── pairingchecker.exe          # Windows
├── tournamentgenerator         # macOS/Linux (no extension)
├── tournamentgenerator.exe     # Windows
├── tiebreakchecker             # macOS/Linux (no extension)
├── tiebreakchecker.exe         # Windows
├── checksums.txt               # SHA256 checksums
└── version.txt                 # Gacrux version
```

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
# Check file sizes
ls -lh engines/*

# Verify checksums
sha256sum -c engines/checksums.txt

# Check version
cat engines/version.txt

# Test binaries (macOS/Linux)
./engines/pairingchecker --help

# Test binaries (Windows)
engines\pairingchecker.exe --help
```

## Support

For issues or questions:
- Check the build log: `engines/build.log`
- Verify prerequisites are met
- Ensure you have write permissions
- Check Python version (3.11+)

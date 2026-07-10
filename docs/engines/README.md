# Gacrux Engines

This directory documents how to obtain and build the Gacrux engine binaries used by Vesus Pairings.

## Overview

Vesus Pairings uses [Gacrux](https://github.com/OttoMilvang/TieBreakServer) for certain Swiss tournament operations. Four engines are provided:

- **pairingchecker** - Used by Vesus for generating and validating chess pairings
- **tournamentgenerator** - Used only for FIDE endorsement procedures
- **tiebreakchecker** - Not used by Vesus; made available for chess operators who might need it
- **ratingsimulation** - Not used by Vesus; made available for chess operators who might need it

Vesus calculates its own standings using custom built logic, so the tiebreak checker from Gacrux is not currently integrated into the application.

## Getting the engines

Most people will want one of these two options:

### Option 1 — Download prebuilt binaries (recommended)

Every release publishes ready-to-run archives for all supported platforms. This is the fastest path if you just want to use an engine.

1. Download the archive for your platform and engine from [GitHub Releases](https://github.com/santino/vesus-pairings-desktop/releases)
2. Verify the archive against the release `checksums.txt`
3. Extract it and run the executable (kept next to its `_internal/` folder)

See **[Distribution](./distribution.md)** for detailed download, verification, and extraction instructions.

### Option 2 — Build locally

Prefer to build from source? The build script clones Gacrux source code, builds all four engines with PyInstaller, and packages them into archives.

```bash
./scripts/build-gacrux.sh --output-dir ./engines
```

See **[Building Engines](./building.md)** for prerequisites, output layout, and troubleshooting.

## Supported Platforms

Each engine is a PyInstaller *onedir* bundle (executable + `_internal/` folder), distributed as a platform-native archive:

| Platform | Architecture | Archive format | Executable extension |
|----------|--------------|----------------|----------------------|
| macOS    | ARM64, x64   | `.tar.gz`      | No extension         |
| Linux    | ARM64, x64   | `.tar.gz`      | No extension         |
| Windows  | ARM64, x64   | `.zip`         | `.exe`               |

On macOS/Linux the executable bit is preserved inside the `.tar.gz`, so no `chmod +x` is needed after extraction.

## For maintainers: automated releases

Repository owners can build and publish all platforms at once via the **[Build Gacrux Engines](../../.github/workflows/build-engines.yml)** GitHub Actions workflow (triggered manually with `workflow_dispatch`, or by pushing to the `engines-update` branch). This is not needed for regular users — the resulting archives are what appear under Releases.

## Documentation

- [Building Engines](./building.md) - Detailed build instructions
- [Distribution](./distribution.md) - Download, verify, and extract released archives

## Resources

- [Gacrux Source](https://github.com/OttoMilvang/TieBreakServer) - Original Gacrux repository
- [GitHub Actions Workflow](../../.github/workflows/build-engines.yml) - Build automation
- [Build Script](../../scripts/build-gacrux.sh) - Local build script

## Versioning

Releases are tagged `gacrux-vX.Y.Z` (e.g., `gacrux-v1.8.48`), matching the upstream Gacrux version the binaries were built from.

Always use the latest version for the best performance, security, and adherence to the latest chess tournament rules.

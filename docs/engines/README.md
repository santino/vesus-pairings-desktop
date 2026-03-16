# Gacrux Engines

This directory contains documentation and resources for building and distributing the Gacrux engine binaries used by Vesus Pairings.

## Quick Links

- [Building Engines](./building.md) - Guide for building binaries locally
- [Distribution](./distribution.md) - Guide for automated builds and releases

## Overview

Vesus Pairings uses Gacrux for certain Swiss tournament operations:

- **pairingchecker** - Used by Vesus for generating and validating chess pairings
- **tournamentgenerator** - Used only for FIDE endorsement procedures
- **tiebreakchecker** - Not used by Vesus; made available for chess operators who might need it

Vesus calculates its own standings using custom built logic, so the tiebreak checker from Gacrux is not currently integrated into the application.

## Supported Platforms

| Platform | Architecture | Binary Extensions |
|----------|--------------|-------------------|
| macOS    | ARM64, x64   | No extension      |
| Linux    | ARM64, x64   | No extension      |
| Windows  | ARM64, x64   | `.exe`            |

## Building

### Local Build

```bash
./scripts/build-gacrux.sh --output-dir ./engines
```

### Automated Build

Trigger the GitHub Actions workflow to build all platforms automatically.

## Getting Binaries

1. **Download from Releases**: Get the latest binaries from GitHub Releases
2. **Build Locally**: Build your own binaries using the build script
3. **Verify Checksums**: Always verify checksums for security

## Documentation

- [Building Engines](./building.md) - Detailed build instructions
- [Distribution](./distribution.md) - GitHub Actions workflow guide
- [macOS Installation](../macos/installation.md) - Install on macOS
- [Linux Installation](../linux/installation.md) - Install on Linux
- [Windows Installation](../windows/installation.md) - Install on Windows

## Resources

- [Gacrux Source](https://github.com/OttoMilvang/TieBreakServer) - Original Gacrux repository
- [GitHub Actions Workflow](../.github/workflows/build-engines.yml) - Build automation
- [Build Script](../../scripts/build-gacrux.sh) - Local build script

## Versioning

Binaries are versioned using the format `engines-vX.Y.Z` (e.g., `engines-v1.0.0`).

Always download the latest version for the best performance, security, and adherence to the latest chess tournaments rules.

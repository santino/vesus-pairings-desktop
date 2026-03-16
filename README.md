# Vesus Pairings (Desktop)

## Download

Always download the latest release from the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases/latest).

## System Requirements

### Minimum Requirements

- **Operating System**: Windows 10, Linux (any recent distribution), or macOS 10.15+
- **Processor**: 64-bit processor (x86_64 or ARM)
- **RAM**: ~300 MB (additional memory may be needed depending on system resources and workload)
- **Disk Space**: 160 MB minimum, plus additional space for user data (events and rating lists)

### Installation

#### Windows

1. Download the executable for your system from the latest release.
2. Run the executable. If you see a warning about an unrecognized app, click "More info" and then "Run anyway".
3. Follow the on-screen instructions.

#### Linux

Available as `.deb` package (Debian, Ubuntu, etc.), `.rpm` package (Fedora, RHEL, etc.), or portable AppImage. See the [Linux installation guide](./docs/linux/installation.md) for details.

#### macOS

1. Download the appropriate executable for your system:
   - `vesus-pairings-desktop-<version>-macos-x86_64` for Intel-based Macs
   - `vesus-pairings-desktop-<version>-macos-arm64` for Apple Silicon Macs
2. Open the downloaded file. If you see a warning that the app cannot be opened because it is from an unidentified developer, go to System Preferences > Security & Privacy and click "Open Anyway".
3. Follow the on-screen instructions.

## Verifying Checksums

Each release includes SHA256 checksums for the executables. To verify the integrity of your download:

1. Download the checksum file (e.g., `SHA256SUMS`) from the same release.
2. Verify the checksum of the downloaded executable:
   - **Windows**: Use `CertUtil -hashfile vesus-pairings-desktop-<version>-windows-x86_64.exe SHA256` and compare with the checksum file.
   - **Linux**: Use `shasum -a 256 vesus-pairings-desktop-<version>-linux-x86_64` and compare with the checksum file.
   - **macOS**: Use `shasum -a 256 vesus-pairings-desktop-<version>-macos-x86_64` and compare with the checksum file.

## Documentation

For more detailed installation instructions, troubleshooting, and platform-specific notes, see the [docs/](./docs) directory.

### Gacrux Engines

Vesus Pairings uses some engines, including [Gacrux](https://github.com/OttoMilvang/TieBreakServer). Gacrux provides a pairing checker, tournament generator, and tiebreak checker (though tiebreak checker is not used by vesus pairings).

These engines are built from the open source Python source code, as compiling them into executables requires specialized engineering knowledge. The binaries are made available to all chess enthusiasts through this repository.

For more information about building and distributing these engines, see the [engines documentation](./docs/engines/README.md).

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a detailed history of changes.

## Support

If you encounter any issues, please file an issue on the [GitHub repository](https://github.com/santino/vesus-pairings-desktop/issues).

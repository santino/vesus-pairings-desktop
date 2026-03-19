# Vesus Pairings (Desktop Edition)

Vesus Pairings is a powerful, feature-rich tournament handler program designed to deliver a seamless experience for organizers and arbiters at every level. Whether managing a school event, a local club competition, or a major international tournament, it ensures efficient, professional, and transparent operations.

Built on the belief that chess should be accessible to everyone, the software is completely free to use with no limitations on players, rounds, or features. It is entirely ad-free with no user tracking, ensuring a private, distraction-free experience.

**Official Page:** [vesus.org/pairings](https://vesus.org/pairings)

This repository distributes the official **Desktop Edition**.

## Download

Always download the latest release from the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases/latest).

### Direct Downloads

| Platform | Architecture | Package | Download |
|----------|--------------|---------|----------|
| 🪟 Windows | x64 | EXE | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_windows_v0.1.0-alpha.2_x64_setup.exe) |
| 🍎 macOS | arm64 | DMG | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_macOS_v0.1.0-alpha.2_arm64.dmg) |
| 🍎 macOS | x64 | DMG | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_macOS_v0.1.0-alpha.2_x64.dmg) |
| 🐧 Linux | x64 | DEB | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_linux_v0.1.0-alpha.2_x64.deb) |
| 🐧 Linux | arm64 | DEB | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_linux_v0.1.0-alpha.2_arm64.deb) |
| 🐧 Linux | x64 | RPM | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_linux_v0.1.0-alpha.2_x64.rpm) |
| 🐧 Linux | arm64 | RPM | [Download](https://github.com/santino/vesus-pairings-desktop/releases/download/v0.1.0-alpha.2/vesus-pairings_linux_v0.1.0-alpha.2_arm64.rpm) |

## Two Editions, One Platform

Vesus Pairings offers the flexibility of a cloud solution with the reliability of a desktop application. You can choose the edition that fits your workflow, or use them together.

### ☁️ The Cloud Version
Available at [vesus.org](https://vesus.org), the cloud edition is designed for convenience and mobility:
- **99.9% Uptime Guarantee**: Reliability you can trust, backed by [transparent public monitoring](https://docs.google.com/spreadsheets/d/1icp0udfB05VRrifgzs1dmc3QaFBQF9CNlI_Z0lVYRzQ).
- **Auto-Updates**: New features roll out seamlessly with no effort from you—no reinstalling required.
- **Universal Access**: Runs on any device with a modern browser, including smartphones, tablets, and even Smart TVs.

### 💻 The Desktop Edition
Distributed here, the desktop edition is optimized for environments where control and offline access are critical:
- **Offline Reliability**: Ideal for venues with challenging internet access or unstable connections.
- **Local File Storage**: Tournaments are saved directly to your hard drive, adhering to standard workflows for local backup and portability.
- **Hybrid Sync**: Seamlessly publish and sync your offline tournaments to the cloud whenever an internet connection is available.

**The two versions complement each other perfectly**, allowing you to work offline at the venue and sync your data to the cloud for public presentation later.

### Key Features

- 🆓 **100% Free & Private** — Unlimited tournaments, players, and rounds. No ads, no user tracking, and no hidden costs.
- ⚖️ **FIDE Compliant** — Supports over 50 tie-breaks (including every FIDE rule). **Swiss Dutch** pairings are powered by [Gacrux](https://www.gacrux.no/), built by a FIDE Technical Commission member.
- 🌍 **Global Standards** — Integrated with 15+ rating lists (FIDE & National Federations) and supports over 15 languages.
- 📤 **Powerful Export** — Generate TRF16, TRF26, JSON, TXT, or a full-featured static HTML website to host anywhere.
- 🛡️ **Reliability** — Built for serious tournaments with a focus on data integrity and professional workflows.

## System Requirements

### Minimum Requirements

- **Operating System**: Windows 10, Linux (any recent distribution), or macOS 10.15+
- **Processor**: 64-bit processor (x86_64 or ARM)
- **RAM**: ~300 MB (additional memory may be needed depending on system resources and workload)
- **Disk Space**: 160 MB minimum, plus additional space for user data (events and rating lists)

### Installation

For detailed installation instructions, troubleshooting, and platform-specific notes, see the [docs/](./docs) directory.

**Quick Start:**

#### Windows
1. Download the executable.
2. Run the executable. If you see a warning about an unrecognized app, click "More info" and then "Run anyway".

#### Linux
Available as `.deb` package (Debian, Ubuntu, etc.) or `.rpm` package (Fedora, RHEL, etc.).

#### macOS
1. Download the DMG appropriate for your architecture (Intel x64 or Apple Silicon arm64).
2. Open the downloaded file. If you see a warning that the app cannot be opened because it is from an unidentified developer, go to System Preferences > Security & Privacy and click "Open Anyway".

## Verifying Checksums

Each release includes SHA256 checksums for the executables. To verify the integrity of your download:

1. Download the checksum file (e.g., `SHA256SUMS`) from the same release.
2. Verify the checksum of the downloaded executable:
   - **Windows**: Use `CertUtil -hashfile vesus-pairings_windows_v<version>_x64_setup.exe SHA256` and compare with the checksum file.
   - **Linux**: Use `shasum -a 256 vesus-pairings_linux_v<version>_x64.deb` and compare with the checksum file.
   - **macOS**: Use `shasum -a 256 vesus-pairings_macOS_v<version>_x64.dmg` and compare with the checksum file.

## Documentation

- **Quick Start Guide**: [PDF Download](https://vesus.org/assets/documents/VesusPairings-QSG_en-GB.pdf)
- **Full User Manual**: [PDF Download](https://vesus.org/assets/documents/VesusPairings-UserManual_en-GB.pdf)

Here is the updated paragraph, adjusted to guide users via the release title:

### Gacrux Engine

Vesus Pairings integrates the [Gacrux](https://github.com/OttoMilvang/TieBreakServer) engine for **Swiss Dutch** pairings. Gacrux is developed by IA Otto Milvang, a member of the FIDE Technical Commission.

Gacrux also provides a pairing checker, tournament generator, and tiebreak checker (though the tiebreak checker is not used by Vesus Pairings). The binaries are built from the open source Python source code, as compiling them into executables requires specialized engineering knowledge.

They are distributed as separate releases in this repository. You can find them on the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases) by looking for the title **Gacrux Engines** (e.g., *Gacrux Engines v1.x.x*).

For more information about building and distributing these engines, see the [engines documentation](./docs/engines/README.md).

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a detailed history of changes.

## Support

If you encounter any issues, please file an issue on the [GitHub repository](https://github.com/santino/vesus-pairings-desktop/issues).

# Linux Installation Guide

## Prerequisites

- A modern Linux distribution
- No special dependencies required
- **CPU Requirements**:
  - `x64` builds require 64-bit x86 processors
  - `arm64` builds require 64-bit ARM processors (e.g., Raspberry Pi 4, ARM-based laptops)

Both `.deb` and `.rpm` packages are available for both x64 and arm64 architectures. Download the appropriate version for your processor.

## Installation Methods

### Option 1: .deb Package (Recommended)

For Debian-based distributions (Ubuntu, Debian, Linux Mint, etc.):

The .deb package provides better system integration - the application will appear in your application menu and can be easily installed by double-clicking the file.

1. Go to the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases/latest)
2. Download the `.deb` package for your architecture:
   - `vesus-pairings_linux_v<version>_x64.deb` for x64 processors
   - `vesus-pairings_linux_v<version>_arm64.deb` for ARM processors
3. Double-click the file to open it in your software manager, then click Install
4. You may be prompted that the package is from an unknown publisher - this is normal for self-hosted apps and can be accepted

Alternatively, you can install from the command line:
```bash
sudo dpkg -i vesus-pairings_linux_v<version>_x64.deb
```
Or use apt:
```bash
sudo apt install ./vesus-pairings_linux_v<version>_x64.deb
```

### Option 2: .rpm Package (Recommended)

For Fedora, RHEL, CentOS, openSUSE, and other RPM-based distributions:

The .rpm package provides better system integration - the application will appear in your application menu and can be easily installed by double-clicking the file.

1. Go to the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases/latest)
2. Download the `.rpm` package for your architecture:
   - `vesus-pairings_linux_v<version>_x64.rpm` for x64 processors
   - `vesus-pairings_linux_v<version>_arm64.rpm` for ARM processors
3. Double-click the file to open it in your software manager, then click Install
4. You may be prompted that the package is from an unknown publisher - this is normal for self-hosted apps and can be accepted

Alternatively, you can install from the command line using `dnf` or `rpm`:
```bash
sudo dnf install vesus-pairings_linux_v<version>_x64.rpm
```
Or:
```bash
sudo rpm -i vesus-pairings_linux_v<version>_x64.rpm
```

## Uninstallation

### If installed via .deb package

```bash
sudo apt-get remove vesus-pairings
```

### If installed via .rpm package

```bash
sudo dnf remove vesus-pairings
```

## Troubleshooting

### Permission Issues

If you get a "permission denied" error when trying to run the executable:

1. Ensure you made it executable with `chmod +x`
2. Check that you're trying to execute the file correctly (using `./` if in current directory)

### Security Warnings

Some Linux distributions may have security mechanisms that prevent execution of downloaded binaries. If you encounter such issues:

1. Verify the checksum of the downloaded file (see README.md)
2. Check your distribution's security documentation for ways to allow execution of trusted binaries

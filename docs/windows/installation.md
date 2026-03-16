# Windows Installation Guide

## Prerequisites

- Windows 10 or later (64-bit)
- Administrator privileges may be required for installation
- **CPU Requirements**: 64-bit processor (x86_64 or ARM)

## Download

1. Go to the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases/latest)
2. Download the Windows executable (works on both x86_64 and ARM processors)

## Installation Steps

1. Locate the downloaded `.exe` file in your Downloads folder
2. Double-click the file to run it
3. If you see a Windows SmartScreen warning:
   - Click "More info"
   - Click "Run anyway"
4. Follow the on-screen instructions to complete the installation
5. The application will launch automatically after installation

## Running the Application

- After installation, you can find Vesus Pairings in your Start menu
- By default, the installer also creates a desktop shortcut, so you can also launch it from your desktop

## Uninstallation

1. Go to Settings > Apps > Apps & features
2. Find "Vesus Pairings" in the list
3. Click on it and select "Uninstall"
4. Follow the prompts to complete the uninstallation
5. Alternatively, you can also uninstall by running the uninstall.exe file located in the program's installation folder

## Troubleshooting

### SmartScreen Warning

Since the executables are not signed (to avoid costs for free software), Windows SmartScreen may warn you. This is normal and safe to bypass by clicking "More info" -> "Run anyway".

### Antivirus False Positives

Some antivirus software may flag unsigned executables. If this happens:

1. Verify the checksum of the downloaded file (see README.md)
2. Add an exception for the executable in your antivirus software
3. Report the false positive to your antivirus vendor if desired

### Execution Policy Issues

If you encounter issues running the executable:

1. Right-click the file and select "Properties"
2. Check if there's an "Unblock" checkbox at the bottom
3. If present, check it and click "Apply"

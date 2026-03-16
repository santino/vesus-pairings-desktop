# macOS Installation Guide

## Prerequisites

- macOS 10.15 (Catalina) or later
- **CPU Requirements**:
  - `x86_64` builds require Intel x86_64 processors
  - `arm64` builds require Apple Silicon (all models)

## Download

1. Go to the [Releases page](https://github.com/santino/vesus-pairings-desktop/releases/latest)
2. Download the appropriate executable for your system:
   - `vesus-pairings_macOS_v<version>_x64.dmg` for x86_64-based Macs
   - `vesus-pairings_macOS_v<version>_arm64.dmg` for Apple Silicon Macs

## Installation Steps

1. Locate the downloaded `.dmg` file in your Downloads folder
2. Double-click the file to open it
3. A license agreement window will appear - review and accept the terms to proceed
4. Drag the "Vesus Pairings" application to your Applications folder (or click and hold, then drag)
5. The application will be installed to your Applications folder

## Running the Application

### First Run

Since the application is unsigned, for the first launch:

1. Go to your Applications folder
2. Right-click on "Vesus Pairings"
3. Select "Open" from the context menu
4. Click "Open" in the dialog that appears to confirm

This step is necessary for unsigned applications. macOS will remember this choice for future runs.

### Subsequent Runs

After the first successful launch:

- You can double-click the application in your Applications folder
- Or find it in Launchpad
- Or search for it using Spotlight
- To keep it in your Dock, right-click the icon in the Dock and select "Options" > "Keep in Dock"

## Uninstallation

1. Quit the application if it's running
2. Go to your Applications folder
3. Find "Vesus Pairings" and drag it to the Trash
4. Optionally, remove user data:
   - Configuration: `~/Library/Application Support/vesus-pairings`
   - Data: `~/Library/Application Support/vesus-pairings`

## Troubleshooting

### First Run Issues

If the application doesn't launch on first attempt:

1. Make sure you've copied the app to your Applications folder
2. Right-click the app in Applications and select "Open" (this is required for unsigned apps)
3. If you see a security dialog, click "Open" to confirm

### "App is damaged" Warning

If you see a warning that the app is damaged and should be moved to the Trash:

1. This can sometimes happen with unsigned apps on newer macOS versions
2. Try opening the app again using right-click > "Open" method described above
3. If that doesn't work, you may need to adjust your security settings:
   - Go to System Settings > Privacy & Security > General
   - Under "Security", look for the option to allow the application
   - Try opening the app again

### Permission Issues

If you encounter permission issues:

1. Ensure you downloaded the complete file (check file size against the release assets)
2. Verify the checksum of the downloaded file (see README.md)
3. Make sure you have read/execute permissions on the file

### Performance Issues

If you experience performance issues:

1. Ensure you downloaded the correct version for your processor type
2. Check that your system meets the minimum requirements (see Prerequisites)

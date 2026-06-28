## 0.3.1 (2026-06-28)

### 🩹 Fixes

- Fix config for Desktop -> Cloud communication, following Cloud architecture refactoring
- Consolidate usage of console tasks on Windows

## 0.3.0 (2026-06-24)

### 🚀 Features

- Open event and backup files from the Desktop application
- Introduce granular SYNC report. Also translate report for Update rating list data
- Introducing diff checks in backups to ensure only fresh backups are stored
- Trim player names when printing TXT pairings to fit A4 and improving direct (non PDF) prints
- Add days left count, in addition to expiry date, to Account connection dropdown
- Vesus Pairings Desktop to open the text report following Update rating list data task

### 🩹 Fixes

- Remove option /P from DE tiebreak on RoundRobin tournaments (since it is always the default behaviour)
- Fix Chess960 position print in Vesus Pairings Desktop application
- Fix logic to set default tournament registrations `start` and `end` dates
- Add protection to Desktop - Cloud SYNC to prevent orphaned pairings
- Better handling of Round Robin Single/Double detection when importing from TRF
- Refactor PDFs to ensure consistent rows handling across pages and better headers and footers
- Strengthen players handling logic for Desktop - Cloud SYNC
- Use semicolons to separate list of players in Sync reports (as comma is already used between Surname and Name)
- Improve logic to add technical configuration to TRF even before the tournament starts
- Fix FSI_ITA TORO report when multiple arbiters on multiple lines are declared
- Fix board cards print
- Ensure update banner does not re-show if it was dismissed with "remind later"
- Fix computing time control with multiple periods when publishing to ChessResults
- Fix PDF exports to always include the correct link to public event (also for Desktop edition)
- Refactor backups auto cleanup on application startup to share consistent logic with backup creation cleanup rules
- Replace cached application version with freshly computed version number on application launch

## 0.2.0 (2026-06-15)

### 🚀 Features

- Open the text report following "Update rating list data" task
- Implement new Fide Event Id field (with link)
- Always show Save and Cancel action buttons in Pairings Manual Edit, when screen is large enough

### 🩹 Fixes

- Set absences immediately when entering late joiners
- Improve data preparation for bi-directional sync
- Make sure to scroll to top of the tab when switching from list to manual edit in Pairings Tab
- Fix Tables to reset ancestor sticky reference when different tables might be rendered under the same tab conditionally
- Fix table top scrollbar z-index position to not override Dropdowns and Dialogs
- Persist tables horizontal scroll position when scrolling up to a position that doesn't require sticky header
- Improve logic to disable participants insert buttons
- Fix Syncronisation success message
- Fix updated boards (plural) usage in sync report

## 0.1.0 (2026-06-10)

### 🚀 Features

- Introduce participants bulk delete and bulk move (between event tournaments) in Vesus Pairings

### 🩹 Fixes

- Better styling for TieBreaks category headings
- Ensure Vesus Pairings Desktop edition shows instructions when searching from database and no rating lists are available
- Fix tournament type field (individual/team) is locked to Individual in Vesus Pairings
- Fix Export PGN Dialog to reset when switching from Multi to Single tournament export

## 0.1.0-beta.3 (2026-06-05)

### 🚀 Features
- Make tables sticky headers interactable
- Add detailed report after sync operations
- Implement granular diff-based strategy when syncing registrations in Vesus Pairings Desktop
- Introduce bi-directional Sync to allow collaboration across multiple users and applications (Cloud, Desktop)
- Introduce Schedule to the Vesus Pairings Prints tab

## 0.1.0-beta.2 (2026-05-25)

### 🚀 Features

- real-time updates now work correctly on Ubuntu 26.04 Wayland / Kernel 7
- Sync additional tournament and event data between Desktop and Cloud
- Improve tab labels: Add count to Participants and round indicators to Pairings
- Implement new Desktop -> Cloud Sync registrations flow from scratch
- Implement new registrations sync protocol between Desktop and Cloud
- Implement table sticky headers and top scrollbar
- Add loader indicator whilst retrieving data on application launch
- Launch application in maximised window

### 🩹 Fixes

- Ensure Desktop application can change tournament Details at any time
- Improve Tournament Schedule to print localised date / time
- Ensure absences are persisted when syncing from Vesus Pairings Cloud to Desktop

## 0.1.0-beta.1 (2026-05-14)

### 🚀 Features

- Introduce automatic backups in Vesus Pairings Desktop application
- Work with integrated rating lists in Vesus Pairings Desktop application
- Implement schedule Print
- Change Desktop - Cloud communication protocol via authentication and public tournament codes
- Implement Desktop authentication via Cloud account
- Introduce Update notification and assisted download
- Support CPUs from before 2013 that don’t support AVX2 instructions optimisations
- introduce compatibility with new Vesus Pairings Desktop application

### 🩹 Fixes

- Improve detection of results source on results clear
- Styling fixes for Import from cloud dialog + logic fixes for First publish
- Minor fixes, ChessResults publishing encoding and standing PDF credits
- Fix print buttons on linux
- Fix SSO authentication claim fallback
- Improve cloud sync reliability, error handling and published state management
- Add device info collection and better validation for desktop authentication, plus cosmetic fixes
- Improve file opening on Windows
- Improve cross-platform printing and sanitize JS injection points
- Persist update info to localStorage to support refreshes
- Improve reliability across restarts and persistent logging
- Fix communication between Desktop and Cloud due to environment variable setup

## 0.1.0-alpha.9 (2026-05-10)

### 🚀 Features

- Work with integrated rating lists in Vesus Pairings Desktop application
- Implement schedule Print

### 🩹 Fixes

- Improve detection of results source on results clear
- Styling fixes for Import from cloud dialog + logic fixes for First publish

## 0.1.0-alpha.8 (2026-05-01)

### 🚀 Features

- Implement first publish for events from Desktop to Cloud
- Remove references to deprecated tieBreakDummy2026 setting
- Add new page to create events in Vesus Pairings Desktop application
- Update Gacrux to v1.7.50
- Add copy to clipboard button to tournament code

### 🩹 Fixes

- Fix timezone conversion when formatting dates
- Fix logic to determine available data when building columns for PDF export

## 0.1.0-alpha.7 (2026-04-15)

### 🩹 Fixes

- Minor fixes, ChessResults publishing encoding and standing PDF credits
- Fix print buttons on linux
- Fix SSO authentication claim fallback

## 0.1.0-alpha.6 (2026-04-10)

### 🚀 Features

- Change Desktop - Cloud communication protocol via authentication and public tournament codes
- Implement Desktop authentication via Cloud account

### 🩹 Fixes

- Improve cloud sync reliability, error handling and published state management
- Add device info collection and better validation for desktop authentication, plus cosmetic fixes

## 0.1.0-alpha.5 (2026-03-31)

### 🩹 Fixes

- Improve file opening on Windows
- Improve cross-platform printing and sanitize JS injection points
- Persist update info to localStorage to support refreshes

## 0.1.0-alpha.4 (2026-03-26)

### 🚀 Features

- Introduce Update notification and assisted download

### 🩹 Fixes

- Improve reliability across restarts and persistent logging

## 0.1.0-alpha.3 (2026-03-22)

### 🩹 Fixes

- Fix communication between Desktop and Cloud due to environment variables setup

## 0.1.0-alpha.2 (2026-03-18)

### 🚀 Features

- Support CPUs from before 2013 that don’t support AVX2 instructions optimisations

## 0.1.0-alpha.1 (2026-03-13)

### 🚀 Features

- Initial release

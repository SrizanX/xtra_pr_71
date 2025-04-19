# XTRA PR71 Router Controller

A mobile application built with Flutter to control and manage your XTRA PR71 pocket router.

## Features

- **Router Control**: Power off, restart, and reset your router remotely
- **Connection Management**: View and manage data connections
- **SMS Management**: Read and send SMS messages
- **User Authentication**: Secure login to protect your router access
- **Settings Configuration**: Customize router settings

## Screenshots

| Login                                     | Home (Data Disabled)                                                  | Home (Data Enabled)                                                 |
| ----------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------- |
| ![Login Screen](screenshots/01_login.png) | ![Home Screen - Data Disabled](screenshots/02_home_data_disabled.png) | ![Home Screen - Data Enabled](screenshots/03_home_data_enabled.png) |

| SMS                                   | Settings                                        |
| ------------------------------------- | ----------------------------------------------- |
| ![SMS Screen](screenshots/04_sms.png) | ![Settings Screen](screenshots/05_settings.png) |

## Getting Started

### Prerequisites

- Flutter SDK 3.5.4 or higher
- Android Studio / VS Code with Flutter plugins

### Installation

1. Clone this repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Technology Stack

- Flutter
- Bloc for state management
- Freezed for immutable data models
- Shared Preferences for local storage

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

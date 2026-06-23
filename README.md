# Tic Tac Toe (Flutter)

A lightweight Flutter implementation of the classic Tic Tac Toe game.

This repository contains a small, well-structured Flutter app with:

- A local two-player mode
- A single-player mode against a simple AI (`ai_service.dart`)
- Clean separation of UI, game logic, and services (`lib/`)
- Unit and widget tests under `test/`

**APK:** A compiled Android package is included in the repository. Download the APK directly here:

[Download tic-tac-toe APK](tic-tac-toe.apk)

## Quick Start

Prerequisites: install the Flutter SDK (stable channel).

Run locally on a connected device or emulator:

```bash
flutter pub get
flutter run
```

Build a release APK locally (optional):

```bash
flutter build apk --release
```

The generated APK from a local build will be placed under `build/app/outputs/flutter-apk/`.

## Project Structure (high level)

- `lib/` — app source: `models/`, `providers/`, `screens/`, `services/`, `widgets/`, `theme/`
- `test/` — unit and widget tests
- `assets/` — images and static resources

## Tests

Run tests with:

```bash
flutter test
```


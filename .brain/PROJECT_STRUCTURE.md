# Project Structure

- `lib/`
  - `main.dart`: App entry point and Provider setup.
  - `models/`: Enums and data structures (`player.dart`, `game_mode.dart`).
  - `providers/`: State management (`game_provider.dart`).
  - `screens/`: UI screens (`home_screen.dart`, `game_screen.dart`).
  - `services/`: Pure game logic and AI algorithms (`game_logic.dart`, `ai_service.dart`).
  - `theme/`: Material 3 theme configurations (`app_theme.dart`).
  - `widgets/`: Reusable UI components (`board_widget.dart`, `cell_widget.dart`, etc.).
- `assets/`: App-level static assets, including `assets/images/app_logo.png` for the home screen logo.
- `test/`: Unit tests for pure logic.
- `android/app/src/main/res/mipmap-*/ic_launcher.png`: Android launcher icon resources generated from the app logo.
- `.brain/`: Persistent memory for the AI agent to maintain project context.
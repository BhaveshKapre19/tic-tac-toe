# Technical Decisions

- **2026-06-23**: Chose `provider` for state management due to its simplicity, robust integration with Flutter, and perfect fit for an app of this size, avoiding the boilerplate of more complex solutions while keeping state separate from UI.
- **2026-06-23**: Decided on Material 3 UI design with a clean, native-feeling approach instead of glassmorphism to align with Google's modern app standards.
- **2026-06-23**: Abstracted game logic and AI into pure Dart classes in `lib/services/` to ensure they are 100% unit-testable independent of the Flutter UI framework.
- **2026-06-23**: Adopted new Flutter 3.44.2 APIs: switched to `CardThemeData` and `.withValues(alpha: ...)` to align with latest Flutter deprecations and ensure zero analysis issues.
- **2026-06-23**: Reused the provided Tic Tac Toe artwork for both the in-app home logo and Android launcher icon resources so the app branding stays consistent across the launcher and first screen.
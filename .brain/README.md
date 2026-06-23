# Tic Tac Toe Premium

A modern, polished Tic Tac Toe application built with Flutter.

## Features
- **Game Modes**: Player vs Player, Player vs AI (Easy, Hard).
- **Hard AI**: Implemented using the Minimax algorithm, making it unbeatable.
- **UI/UX**: Material 3 design, light/dark themes, responsive layout, smooth animations.

## How to Run
Ensure you have Flutter installed.
```bash
flutter pub get
flutter run
```

## How to Test
The core game logic and AI algorithms are purely decoupled from the UI and fully tested.
```bash
flutter test
```

## AI Implementation
- **Easy**: Selects a valid random open spot.
- **Hard**: Uses Minimax to recursively evaluate all possible future moves and picks the optimal one, assuming optimal play from the opponent. The AI will either win or draw, it cannot lose.

enum Player {
  X,
  O,
}

extension PlayerExtension on Player {
  String get symbol => this == Player.X ? 'X' : 'O';
  Player get opponent => this == Player.X ? Player.O : Player.X;
}

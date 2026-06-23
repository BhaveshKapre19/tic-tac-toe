import '../models/player.dart';

class GameLogic {
  /// Returns the winning player if there is one, otherwise null.
  static Player? checkWinner(List<Player?> board) {
    const winningLines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var line in winningLines) {
      if (board[line[0]] != null &&
          board[line[0]] == board[line[1]] &&
          board[line[0]] == board[line[2]]) {
        return board[line[0]];
      }
    }
    return null;
  }

  /// Returns the winning line indices if there is a winner, otherwise null.
  static List<int>? getWinningLine(List<Player?> board) {
    const winningLines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var line in winningLines) {
      if (board[line[0]] != null &&
          board[line[0]] == board[line[1]] &&
          board[line[0]] == board[line[2]]) {
        return line;
      }
    }
    return null;
  }

  /// Returns true if the board is full (draw).
  static bool checkDraw(List<Player?> board) {
    return !board.contains(null) && checkWinner(board) == null;
  }
}

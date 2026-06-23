import 'dart:math';
import '../models/player.dart';
import 'game_logic.dart';

class AIService {
  static final Random _random = Random();

  /// Makes a random valid move.
  static int getEasyMove(List<Player?> board) {
    List<int> available = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == null) {
        available.add(i);
      }
    }
    if (available.isEmpty) return -1;
    return available[_random.nextInt(available.length)];
  }

  /// Returns the best move using Minimax algorithm.
  static int getHardMove(List<Player?> board, Player aiPlayer) {
    int bestScore = -10000;
    int bestMove = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == null) {
        board[i] = aiPlayer;
        int score = _minimax(board, 0, false, aiPlayer, -10000, 10000);
        board[i] = null;
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  static int _minimax(List<Player?> board, int depth, bool isMaximizing, Player aiPlayer, int alpha, int beta) {
    Player? winner = GameLogic.checkWinner(board);
    if (winner != null) {
      return winner == aiPlayer ? 10 - depth : depth - 10;
    }
    if (GameLogic.checkDraw(board)) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -10000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == null) {
          board[i] = aiPlayer;
          int score = _minimax(board, depth + 1, false, aiPlayer, alpha, beta);
          board[i] = null;
          bestScore = max(score, bestScore);
          alpha = max(alpha, bestScore);
          if (beta <= alpha) break;
        }
      }
      return bestScore;
    } else {
      int bestScore = 10000;
      Player humanPlayer = aiPlayer.opponent;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == null) {
          board[i] = humanPlayer;
          int score = _minimax(board, depth + 1, true, aiPlayer, alpha, beta);
          board[i] = null;
          bestScore = min(score, bestScore);
          beta = min(beta, bestScore);
          if (beta <= alpha) break;
        }
      }
      return bestScore;
    }
  }
}

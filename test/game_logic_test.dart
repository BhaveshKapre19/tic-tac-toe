import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/services/game_logic.dart';

void main() {
  group('GameLogic', () {
    test('checkWinner returns X when X has a winning line', () {
      final board = [
        Player.X, Player.X, Player.X,
        null, null, null,
        null, null, null,
      ];
      expect(GameLogic.checkWinner(board), Player.X);
    });

    test('checkWinner returns null when no one has a winning line', () {
      final board = [
        Player.X, Player.O, Player.X,
        null, null, null,
        null, null, null,
      ];
      expect(GameLogic.checkWinner(board), isNull);
    });

    test('checkDraw returns true when board is full and no winner', () {
      final board = [
        Player.X, Player.O, Player.X,
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.O,
      ];
      expect(GameLogic.checkWinner(board), isNull);
      expect(GameLogic.checkDraw(board), isTrue);
    });

    test('checkDraw returns false when board is full but there is a winner', () {
      final board = [
        Player.X, Player.X, Player.X,
        Player.X, Player.O, Player.O,
        Player.O, Player.X, Player.O,
      ];
      expect(GameLogic.checkDraw(board), isFalse);
    });
  });
}

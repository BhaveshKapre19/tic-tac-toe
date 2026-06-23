import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/services/ai_service.dart';

void main() {
  group('AIService', () {
    test('Easy mode picks a valid empty spot', () {
      final board = [
        Player.X, Player.O, Player.X,
        Player.O, null, Player.O,
        Player.X, Player.O, Player.X,
      ];
      final move = AIService.getEasyMove(board);
      expect(move, 4);
    });

    test('Hard mode (Minimax) picks the winning move', () {
      // O can win by playing at index 5
      final board = [
        Player.X, Player.X, null,
        Player.O, Player.O, null,
        null, null, null,
      ];
      final move = AIService.getHardMove(board, Player.O);
      expect(move, 5);
    });

    test('Hard mode (Minimax) blocks the opponent from winning', () {
      // X is about to win at index 2, O must block
      final board = [
        Player.X, Player.X, null,
        null, Player.O, null,
        null, null, null,
      ];
      final move = AIService.getHardMove(board, Player.O);
      expect(move, 2);
    });
  });
}

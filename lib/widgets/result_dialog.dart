import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/player.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameProvider>();
    String title;
    if (game.isDraw) {
      title = 'It\'s a Draw!';
    } else {
      final winnerName = game.winner == Player.X ? 'Player X' : game.playerOName;
      title = '$winnerName Wins!';
    }

    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        'Would you like to play again?',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Go back to home
          },
          child: const Text('Menu'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            game.resetBoard(); // Reset game
          },
          child: const Text('Play Again'),
        ),
      ],
    );
  }
}

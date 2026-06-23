import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/player.dart';

class CellWidget extends StatelessWidget {
  final int index;

  const CellWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        final player = game.board[index];
        final isWinningCell = game.winningLine?.contains(index) ?? false;

        return InkWell(
          onTap: () => game.makeMove(index),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isWinningCell 
                  ? Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.2)
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: AnimatedScale(
                scale: player != null ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                child: Text(
                  player?.symbol ?? '',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: player == Player.X 
                          ? Theme.of(context).colorScheme.primary 
                          : Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

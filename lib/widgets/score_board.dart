import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/player.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _ScoreCard(
                title: game.playerXName,
                score: game.scoreX,
                color: Theme.of(context).colorScheme.primary,
                isActive: game.currentPlayer == Player.X && !game.isGameOver && !game.isProcessingAI,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ScoreCard(
                title: 'Draws',
                score: game.scoreDraws,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                isActive: false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ScoreCard(
                title: game.playerOName,
                score: game.scoreO,
                color: Theme.of(context).colorScheme.secondary,
                isActive: (game.currentPlayer == Player.O || game.isProcessingAI) && !game.isGameOver,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final int score;
  final Color color;
  final bool isActive;

  const _ScoreCard({
    required this.title,
    required this.score,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? color : Colors.transparent,
          width: 2,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

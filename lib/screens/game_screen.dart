import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../providers/game_provider.dart';
import '../widgets/board_widget.dart';
import '../widgets/score_board.dart';
import '../widgets/result_dialog.dart';
import '../models/player.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late ConfettiController _confettiController;
  bool _wasGameOver = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().addListener(_onGameStateChanged);
    });
  }

  void _onGameStateChanged() {
    if (!mounted) return;
    final game = context.read<GameProvider>();
    if (game.isGameOver && !_wasGameOver) {
      if (game.winner != null) {
        _confettiController.play();
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ResultDialog(),
      );
    }
    _wasGameOver = game.isGameOver;
  }

  @override
  void dispose() {
    // Remove listener on dispose to prevent memory leaks
    if (mounted) {
       // It's safe not to remove here if we just handle mounted in callback, but cleaner to remove.
    }
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameProvider>().resetBoard();
            },
          ),
        ],
      ),
      body: Consumer<GameProvider>(
        builder: (context, game, child) {
          return Stack(
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ScoreBoard(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: BoardWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: _TurnIndicator(game: game),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TurnIndicator extends StatelessWidget {
  final GameProvider game;

  const _TurnIndicator({required this.game});

  @override
  Widget build(BuildContext context) {
    if (game.isGameOver) {
      return const SizedBox(height: 56);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (game.isProcessingAI)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Text(
                game.currentPlayer == Player.X ? '${game.playerXName}\'s Turn' : '${game.playerOName}\'s Turn',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: game.currentPlayer == Player.X
                        ? Theme.of(context).colorScheme.primary 
                        : Theme.of(context).colorScheme.secondary,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}

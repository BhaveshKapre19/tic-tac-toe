import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/game_mode.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grid_3x3_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Tic Tac Toe',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 48),
                  _ModeButton(
                    title: 'Player vs Player',
                    icon: Icons.people_outline,
                    onTap: () => _showNameDialog(context, GameMode.pvp),
                  ),
                  const SizedBox(height: 16),
                  _ModeButton(
                    title: 'Player vs AI (Easy)',
                    icon: Icons.smart_toy_outlined,
                    onTap: () => _showNameDialog(context, GameMode.aiEasy),
                  ),
                  const SizedBox(height: 16),
                  _ModeButton(
                    title: 'Player vs AI (Hard)',
                    icon: Icons.psychology_outlined,
                    onTap: () => _showNameDialog(context, GameMode.aiHard),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showNameDialog(BuildContext context, GameMode mode) {
    final TextEditingController p1Controller = TextEditingController();
    final TextEditingController p2Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mode == GameMode.pvp ? 'Enter Player Names' : 'Enter Your Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: p1Controller,
                decoration: InputDecoration(
                  labelText: mode == GameMode.pvp ? 'Player 1 Name (X)' : 'Your Name (X)',
                ),
              ),
              if (mode == GameMode.pvp) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: p2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Player 2 Name (O)',
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<GameProvider>().setGameMode(
                  mode, 
                  playerXName: p1Controller.text,
                  playerOName: mode == GameMode.pvp ? p2Controller.text : null,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text('Start Game'),
            ),
          ],
        );
      },
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ModeButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}

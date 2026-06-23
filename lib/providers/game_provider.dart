import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/game_mode.dart';
import '../services/game_logic.dart';
import '../services/ai_service.dart';

class GameProvider extends ChangeNotifier {
  GameMode _mode = GameMode.pvp;
  List<Player?> _board = List.generate(9, (_) => null);
  Player _currentPlayer = Player.X;
  Player? _winner;
  bool _isDraw = false;
  List<int>? _winningLine;
  bool _isProcessingAI = false;

  int _scoreX = 0;
  int _scoreO = 0;
  int _scoreDraws = 0;

  String _playerXName = 'Player X';
  String _playerOName = 'Player O';
  static const List<String> _aiNamesList = [
    'Bhavesh', 'Prashant', 'Far', 'Caro', 'Plam', 'Gloria' , 'Sonali' , 'Shivani' , 'Harsh'
  ];

  GameMode get mode => _mode;
  String get playerXName => _playerXName;
  String get playerOName => _playerOName;
  List<Player?> get board => _board;
  Player get currentPlayer => _currentPlayer;
  Player? get winner => _winner;
  bool get isDraw => _isDraw;
  List<int>? get winningLine => _winningLine;
  bool get isGameOver => _winner != null || _isDraw;
  bool get isProcessingAI => _isProcessingAI;
  int get scoreX => _scoreX;
  int get scoreO => _scoreO;
  int get scoreDraws => _scoreDraws;

  void setGameMode(GameMode mode, {String? playerXName, String? playerOName}) {
    _mode = mode;
    if (playerXName != null && playerXName.trim().isNotEmpty) {
      _playerXName = playerXName.trim();
    } else {
      _playerXName = 'Player X';
    }
    
    if (mode == GameMode.pvp) {
      if (playerOName != null && playerOName.trim().isNotEmpty) {
        _playerOName = playerOName.trim();
      } else {
        _playerOName = 'Player O';
      }
    }
    
    resetBoard();
    resetScores();
  }

  void resetScores() {
    _scoreX = 0;
    _scoreO = 0;
    _scoreDraws = 0;
    notifyListeners();
  }

  void resetBoard() {
    _board = List.generate(9, (_) => null);
    _currentPlayer = Player.X;
    _winner = null;
    _isDraw = false;
    _winningLine = null;
    _isProcessingAI = false;

    if (_mode == GameMode.aiEasy || _mode == GameMode.aiHard) {
      int index = Random().nextInt(_aiNamesList.length);
      String newAIName = _aiNamesList[index];
      if (newAIName.toLowerCase() == _playerXName.toLowerCase()) {
        index = (index + 1) % _aiNamesList.length;
        newAIName = _aiNamesList[index];
      }
      _playerOName = newAIName;
    }

    notifyListeners();
  }

  void makeMove(int index) async {
    if (_board[index] != null || isGameOver || _isProcessingAI) return;

    _board[index] = _currentPlayer;
    _checkGameState();

    if (!isGameOver) {
      _currentPlayer = _currentPlayer.opponent;
      notifyListeners();

      if ((_mode == GameMode.aiEasy || _mode == GameMode.aiHard) && _currentPlayer == Player.O) {
        _isProcessingAI = true;
        notifyListeners();
        
        // Small delay for natural feel
        await Future.delayed(const Duration(milliseconds: 500));
        
        int aiMove;
        if (_mode == GameMode.aiEasy) {
          aiMove = AIService.getEasyMove(List.from(_board));
        } else {
          aiMove = AIService.getHardMove(List.from(_board), Player.O);
        }
        
        if (aiMove != -1 && !isGameOver) {
          _board[aiMove] = Player.O;
          _checkGameState();
          if (!isGameOver) {
             _currentPlayer = Player.X;
          }
        }
        _isProcessingAI = false;
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }

  void _checkGameState() {
    _winner = GameLogic.checkWinner(_board);
    _winningLine = GameLogic.getWinningLine(_board);
    _isDraw = GameLogic.checkDraw(_board);

    if (_winner == Player.X) {
      _scoreX++;
    } else if (_winner == Player.O) {
      _scoreO++;
    } else if (_isDraw) {
      _scoreDraws++;
    }
  }
}

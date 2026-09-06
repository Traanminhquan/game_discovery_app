import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/game_service.dart';

class GameProvider extends ChangeNotifier {
  final GameService _gameService = GameService();

  List<Game> _games = [];
  List<Game> _filteredGames = [];

  bool _isLoading = false;
  String? _errorMessage;

  String _searchQuery = '';
  String _selectedGenre = 'All';

  List<Game> get games => _filteredGames;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String get selectedGenre => _selectedGenre;

  List<String> get genres {
    final genreList = _games
        .map((game) => game.genre)
        .where((genre) => genre.isNotEmpty)
        .toSet()
        .toList();

    genreList.sort();

    return ['All', ...genreList];
  }

  Future<void> loadGames() async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      _games = await _gameService.getGames();

      _applyFilters();
    } catch (error) {
      _errorMessage = 'Failed to load games';
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void searchGames(String query) {
    _searchQuery = query;

    _applyFilters();

    notifyListeners();
  }

  void filterByGenre(String genre) {
    _selectedGenre = genre;

    _applyFilters();

    notifyListeners();
  }

  void _applyFilters() {
    _filteredGames = _games.where((game) {
      final matchesSearch = game.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

      final matchesGenre =
          _selectedGenre == 'All' ||
          game.genre == _selectedGenre;

      return matchesSearch && matchesGenre;
    }).toList();
  }
}
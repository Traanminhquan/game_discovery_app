import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  static const String _key = 'favorite_game_ids';

  final Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int gameId) {
    return _favoriteIds.contains(gameId);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final savedIds = prefs.getStringList(_key) ?? [];

    _favoriteIds
      ..clear()
      ..addAll(
        savedIds
            .map((id) => int.tryParse(id))
            .whereType<int>(),
      );

    notifyListeners();
  }

  Future<void> toggleFavorite(int gameId) async {
    if (_favoriteIds.contains(gameId)) {
      _favoriteIds.remove(gameId);
    } else {
      _favoriteIds.add(gameId);
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _key,
      _favoriteIds
          .map((id) => id.toString())
          .toList(),
    );

    notifyListeners();
  }
}
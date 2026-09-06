import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game.dart';

class GameService {
  static const String baseUrl = 'https://www.freetogame.com/api';

  Future<List<Game>> getGames() async {
    final response = await http.get(
      Uri.parse('$baseUrl/games'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map(
            (json) => Game.fromJson(json),
          )
          .toList();
    }

    throw Exception('Failed to load games');
  }
}
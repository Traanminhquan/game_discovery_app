import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/favorite_provider.dart';
import '../../providers/game_provider.dart';
import '../../widgets/game_card.dart';
import '../game_detail/game_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gameProvider =
        context.watch<GameProvider>();

    final favoriteProvider =
        context.watch<FavoriteProvider>();

    final favoriteGames = gameProvider.allGames
        .where(
          (game) => favoriteProvider
              .isFavorite(game.id),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
        ),
      ),
      body: favoriteGames.isEmpty
          ? const Center(
              child: Text(
                'No favorite games yet',
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(16),
              itemCount:
                  favoriteGames.length,
              itemBuilder:
                  (context, index) {
                final game =
                    favoriteGames[index];

                return GameCard(
                  title: game.title,
                  genre: game.genre,
                  platform: game.platform,
                  thumbnail: game.thumbnail,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) {
                          return GameDetailScreen(
                            gameId: game.id,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/game.dart';
import '../../services/game_service.dart';
import '../../providers/favorite_provider.dart';

class GameDetailScreen extends StatefulWidget {
  final int gameId;

  const GameDetailScreen({
    super.key,
    required this.gameId,
  });

  @override
  State<GameDetailScreen> createState() =>
      _GameDetailScreenState();
}

class _GameDetailScreenState
    extends State<GameDetailScreen> {
  final GameService gameService = GameService();

  Game? game;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    loadGameDetail();
  }

  Future<void> loadGameDetail() async {
    try {
      final result =
          await gameService.getGameDetail(
        widget.gameId,
      );

      if (!mounted) return;

      setState(() {
        game = result;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage =
            'Failed to load game detail';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Detail',
        ),
        actions: [
          if (game != null)
            Consumer<FavoriteProvider>(
              builder: (
                context,
                favoriteProvider,
                child,
              ) {
                final isFavorite =
                    favoriteProvider.isFavorite(
                  game!.id,
                );

                return IconButton(
                  onPressed: () {
                    favoriteProvider.toggleFavorite(
                      game!.id,
                    );
                  },
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                );
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(errorMessage!),
      );
    }

    if (game == null) {
      return const Center(
        child: Text(
          'Game not found',
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(12),
            child: Image.network(
              game!.thumbnail,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            game!.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _buildInfoRow(
            'Genre',
            game!.genre,
          ),

          _buildInfoRow(
            'Platform',
            game!.platform,
          ),

          _buildInfoRow(
            'Publisher',
            game!.publisher,
          ),

          _buildInfoRow(
            'Developer',
            game!.developer,
          ),

          _buildInfoRow(
            'Release date',
            game!.releaseDate,
          ),

          const SizedBox(height: 20),

          const Text(
            'About this game',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            game!.description.isNotEmpty
                ? game!.description
                : game!.shortDescription,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),

          if (game!.screenshots.isNotEmpty) ...[
            const SizedBox(height: 24),

            const Text(
              'Screenshots',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection:
                    Axis.horizontal,
                itemCount:
                    game!.screenshots.length,
                separatorBuilder:
                    (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
                itemBuilder:
                    (context, index) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                    child: Image.network(
                      game!.screenshots[index],
                      width: 280,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
  ) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
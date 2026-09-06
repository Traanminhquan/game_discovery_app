import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';
import '../../widgets/game_card.dart';
import '../game_detail/game_detail_screen.dart';
import '../favorites/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<GameProvider>().loadGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Discovery',
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: TextField(
                onChanged: (value) {
                  context
                      .read<GameProvider>()
                      .searchGames(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search games...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: DropdownButtonFormField<String>(
                initialValue:
                    gameProvider.selectedGenre,
                decoration: InputDecoration(
                  labelText: 'Genre',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
                items: gameProvider.genres.map(
                  (genre) {
                    return DropdownMenuItem(
                      value: genre,
                      child: Text(genre),
                    );
                  },
                ).toList(),
                onChanged: (genre) {
                  if (genre != null) {
                    context
                        .read<GameProvider>()
                        .filterByGenre(genre);
                  }
                },
              ),
            ),

            Expanded(
              child: _buildGameList(
                gameProvider,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const FavoritesScreen();
                },
              ),
            );

            return;
          }

          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildGameList(
    GameProvider gameProvider,
  ) {
    if (gameProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (gameProvider.errorMessage != null) {
      return Center(
        child: Text(
          gameProvider.errorMessage!,
        ),
      );
    }

    if (gameProvider.games.isEmpty) {
      return const Center(
        child: Text(
          'No games found',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      itemCount: gameProvider.games.length,
      itemBuilder: (context, index) {
        final game =
            gameProvider.games[index];

        return GameCard(
          title: game.title,
          genre: game.genre,
          platform: game.platform,
          thumbnail: game.thumbnail,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return GameDetailScreen(
                    gameId: game.id,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
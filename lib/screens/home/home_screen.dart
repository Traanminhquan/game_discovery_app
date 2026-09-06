import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_service.dart';
import '../../widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GameService gameService = GameService();

  List<Game> games = [];

  bool isLoading = true;
  String? errorMessage;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    loadGames();
  }

  Future<void> loadGames() async {
    try {
      final result = await gameService.getGames();

      setState(() {
        games = result;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load games';
        isLoading = false;
      });
    }
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
        ),
      );
    }

    if (games.isEmpty) {
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
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];

        return GameCard(
          title: game.title,
          genre: game.genre,
          platform: game.platform,
          thumbnail: game.thumbnail,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search games...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            Expanded(
              child: buildBody(),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
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
}
import 'package:flutter/material.dart';
import '../../widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Map<String, String>> games = [
    {
      'title': 'Overwatch 2',
      'genre': 'Shooter',
      'platform': 'PC',
    },
    {
      'title': 'Valorant',
      'genre': 'Shooter',
      'platform': 'PC',
    },
    {
      'title': 'League of Legends',
      'genre': 'MOBA',
      'platform': 'PC',
    },
    {
      'title': 'Genshin Impact',
      'genre': 'Action RPG',
      'platform': 'PC / Mobile',
    },
    {
      'title': 'Hearthstone',
      'genre': 'Card Game',
      'platform': 'PC / Mobile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Discovery'),
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
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];

                  return GameCard(
                    title: game['title']!,
                    genre: game['genre']!,
                    platform: game['platform']!,
                  );
                },
              ),
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
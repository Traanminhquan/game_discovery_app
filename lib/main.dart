import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/favorite_provider.dart';
import 'providers/game_provider.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = FavoriteProvider();

            provider.loadFavorites();

            return provider;
          },
        ),
      ],
      child: const GameDiscoveryApp(),
    ),
  );
}

class GameDiscoveryApp extends StatelessWidget {
  const GameDiscoveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Discovery',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
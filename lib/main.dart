import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const GameDiscoveryApp());
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
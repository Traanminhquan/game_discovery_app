import 'package:flutter/material.dart';
//import 'package:game_discovery_app/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'providers/favorite_provider.dart';
import 'providers/game_provider.dart';
//import 'screens/home/home_screen.dart';
import 'providers/auth_provider.dart';
//import 'screens/auth/login_screen.dart';
import 'screens/auth/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
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
      home: const AuthGate(),
    );
  }
}
import 'package:flutter/material.dart';

// SCREENS IMPORT
import 'package:sing_verse_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/login_screen.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:sing_verse_app/features/home/presentation/screens/home_screen.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/profile_screen.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/settings_screen.dart';

// PROVIDER
import 'package:provider/provider.dart';
import 'package:sing_verse_app/features/room/presentation/room_settings_controller.dart';

void main() {
  runApp(const SingVerseApp());
}

class SingVerseApp extends StatelessWidget {
  const SingVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RoomSettingsController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SingVerse',

        initialRoute: '/splash',

        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
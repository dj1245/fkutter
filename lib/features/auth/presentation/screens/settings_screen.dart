import 'package:flutter/material.dart';
import 'package:sing_verse_app/core/utils/double_back_exit.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/edit_profile_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
      backgroundColor: const Color(0xff0f0c29),
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xff302b63),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _tile(
            icon: Icons.person,
            title: "Edit Profile",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(),
                ),
              );
            },
          ),
          _tile(
            icon: Icons.lock,
            title: "Privacy",
            onTap: () {},
          ),
          _tile(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {},
          ),
        ],
      ),
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xff1c1b33),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sing_verse_app/core/utils/double_back_exit.dart';
import 'edit_profile_screen.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
      backgroundColor: const Color(0xfff5f6fb),

      body: SingleChildScrollView(
        child: Column(
          children: [

            //================ TOP COVER =================//
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff8E2DE2), Color(0xffFF416C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Text(
                          "OFFICIAL VOLUNTEER",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Positioned(
                        top: 40,
                        left: 15,
                        child: Icon(Icons.menu, color: Colors.white),
                      ),

                      const Positioned(
                        top: 40,
                        right: 60,
                        child: Icon(Icons.share, color: Colors.white),
                      ),

                      Positioned(
                        top: 40,
                        right: 15,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                          child: const Icon(Icons.settings, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/avatar.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            const Text(
              "乂VAMPIRE乂",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // BADGES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                badge("Lv.0", Colors.pink),
                badge("VIP 0", Colors.orange),
                badge("⭐ 0", Colors.blue),
                badge("🔥 0", Colors.indigo),
              ],
            ),

            const SizedBox(height: 20),

            // STATS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  statItem("0", "Likes"),
                  statItem("0", "Following"),
                  statItem("0", "Followers"),
                  statItem("0", "Visitors"),
                  statItem("0", "Ranked"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // CONTRIBUTION CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xffFF416C), Color(0xffFF4B2B)],
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contribution Ranking",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(Icons.emoji_events, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // FEATURE CARDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  expandedCard("Karaoke Room", Icons.mic, Colors.blue),
                  const SizedBox(width: 10),
                  expandedCard("Family", Icons.shield, Colors.purple),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // GRID MENU
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 5,
                children: [
                  menuItem(Icons.mic, "Recording"),
                  menuItem(Icons.favorite, "Requests"),
                  menuItem(Icons.workspace_premium, "VIP"),
                  menuItem(Icons.account_balance_wallet, "Wallet"),
                  menuItem(Icons.store, "Store"),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      ),
    );
  }

  // ================= HELPERS =================

  static Widget badge(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: color)),
    );
  }

  static Widget statItem(String number, String title) {
    return Column(
      children: [
        Text(number,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  static Widget expandedCard(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget menuItem(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(radius: 22, backgroundColor: Colors.white),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
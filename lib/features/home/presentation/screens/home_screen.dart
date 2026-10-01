import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/auth/presentation/screens/profile_screen.dart';
import 'package:sing_verse_app/features/home/presentation/widgets/banners/banner_slider.dart';
import 'package:sing_verse_app/features/home/presentation/widgets/rooms/live_room_card.dart';
import 'package:sing_verse_app/features/room/presentation/screens/create_room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  final pages = [
    const Center(child: Text("Room Screen")),
    const HomeContent(),
    const Center(child: Text("Sing Screen")),
    const Center(child: Text("Chat Screen")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFF5F5F5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined),
            activeIcon: Icon(Icons.public),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Room",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: "Sing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🏠 HOME CONTENT
////////////////////////////////////////////////////////////

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {

  bool hasRoom = false;

  late AnimationController _controller;
  late Animation<double> _glow;

  final List<IconData> liveUsers = [
    Icons.person,
    Icons.person_2,
    Icons.person_3,
  ];

  int liveIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {"users": 12},
    {"users": 8},
    {"users": 5},
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _glow = Tween<double>(begin: 1.0, end: 1.25).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openCreateRoom(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateRoomScreen()),
    );

    /// ✅ FIX: safe return from RoomScreen flow
    if (result == true && mounted) {
      setState(() {
        hasRoom = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final activeRooms =
    rooms.where((room) => (room["users"] ?? 0) >= 1).toList()
      ..sort((a, b) => (b["users"] ?? 0).compareTo(a["users"] ?? 0));

    return SafeArea(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search songs or users...",
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      Icon(Icons.mic, size: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                      GestureDetector(
                        onTap: () {
                          if (!hasRoom) {
                            openCreateRoom(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("My Room Open")),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/room.png",
                              height: 55,
                              width: 55,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hasRoom ? "My Room" : "Create Room",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      _icon("Online", "assets/icons/online.png", 45),
                      const SizedBox(width: 10),
                      _icon("Ranking", "assets/icons/ranking.png", 45),
                      const SizedBox(width: 10),
                      _icon("Event Center", "assets/icons/event.png", 45),

                      const SizedBox(width: 10),

                      Column(
                        children: [
                          AnimatedBuilder(
                            animation: _glow,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _glow.value,
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Icon(liveUsers[liveIndex], color: Colors.red),
                                ),
                              );
                            },
                          ),
                          const Text("Live", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                const BannerSlider(),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "🔥 Live Rooms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: activeRooms.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final room = activeRooms[index];

                return LiveRoomCard(
                  users: room["users"],
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(String title, String path, double size) {
    return Column(
      children: [
        Image.asset(path, height: size, width: size),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
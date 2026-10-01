
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class RoomInfoOptionsSheet extends StatefulWidget {
  final Function(File?) onCoverSelected;
  final Function(File?) onBackgroundSelected;
  final Function(String)? onAnnouncementChanged;

  const RoomInfoOptionsSheet({
  super.key,
    required this.onCoverSelected,
    required this.onBackgroundSelected,
    required this.onAnnouncementChanged,
});


  @override
  State<RoomInfoOptionsSheet> createState() => _RoomInfoOptionsSheetState();
}

class _RoomInfoOptionsSheetState extends State<RoomInfoOptionsSheet> {
  String whoCanJoin = "Everyone";
  String whoCanBeSeated = "Everyone";
  List<String> blockedUsers = [
  "User 1",
  "User 2",
  "User 3",
  ];
  File? coverImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickCoverPhoto() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final file = File(image.path);
      widget.onCoverSelected(file);
      Navigator.pop(context);
    }
  }
  Future<void> pickBackground() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final file = File(image.path);
      widget.onBackgroundSelected(file);
      Navigator.pop(context);
    }
  }
  void removeBackground() {
    widget.onBackgroundSelected?.call(null);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F7),

      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 45),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Edit Room Setting",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// BASIC INFO TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            /// LIST
            Expanded(
              child: ListView(
                children: [

                  _tile("Change Cover Photo", onTap: pickCoverPhoto),
                  _divider(),
                  _tile(
                    "Background",
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text("Change Background"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickBackground();
                                  },
                                ),

                                ListTile(
                                  leading: const Icon(Icons.delete, color: Colors.red),
                                  title: const Text("Remove Background"),
                                  onTap: () {
                                    widget.onBackgroundSelected?.call(null);
                                    Navigator.pop(context);
                                  },
                                ),

                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  _divider(),
                  _tile(
                    "Announcement",
                    onTap: () async {

                      final prefs = await SharedPreferences.getInstance();

                      final savedText =
                          prefs.getString('room_announcement') ?? '';

                      final controller =
                      TextEditingController(text: savedText);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Scaffold(
                            backgroundColor: Colors.white,
                            appBar: AppBar(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              leading: IconButton(
                                icon: const Icon(Icons.close, color: Colors.black),
                                onPressed: () => Navigator.pop(context),
                              ),
                              title: const Text(
                                "Announcement",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final prefs =
                                    await SharedPreferences.getInstance();

                                    await prefs.setString(
                                      'room_announcement',
                                      controller.text,
                                    );

                                    widget.onAnnouncementChanged
                                        ?.call(controller.text);

                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Color(0xFF25D366),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(12),
                              child: TextField(
                                controller: controller,
                                maxLines: null,
                                expands: true,
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  hintText: "Write announcement...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  _divider(),
                  _tile("Room Mode"),
                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Text(
                      "Room Admin",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  _tile(
                    "Owner",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  child: Icon(Icons.person, size: 40),
                                ),
                                const SizedBox(height: 12),

                                const Text(
                                  "Vampire Prince",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                const Text(
                                  "ID: 12345678",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                const Text(
                                  "Welcome to my profile.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text("125"),
                                        Text("Follow"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("80"),
                                        Text("Following"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("24"),
                                        Text("Posts"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  _tile(
                    "Co-Owner",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CoOwnerPage(),
                        ),
                      );
                    },
                  ),
                  _tile(
                    "Admin",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Text(
                      "Room Management",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  _tile(
                    "Who Can Join",
                    subtitle: whoCanJoin,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 38),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius
                                  .circular(20),
                              ),
                            ),
                            child: WhoCanJoinSheet(
                              selected: whoCanJoin,
                              onSelect: (value) {
                                setState(() {
                                  whoCanJoin = value;
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  _tile(
                    "Who Can Be Seated",
                    subtitle: whoCanBeSeated,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: WhoCanBeSeatedSheet(
                              selected: whoCanBeSeated,
                              onSelect: (value) {
                                setState(() {
                                  whoCanBeSeated = value;
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
              _tile(
                "Block List",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return const BlockListSheet();
                    },
                  );
                },
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TILE (NOW CLICKABLE)
  Widget _tile(String title, {String? subtitle, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: Color(0xFFBDBDC2),
            ),
          ],
        ),
      ),
    );
  }

  /// DIVIDER
  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.only(left: 16),
      child: Divider(
        height: 1,
        color: Color(0xFFE5E5EA),
      ),
    );
  }
}
class CoOwnerPage extends StatelessWidget {
  const CoOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Co-Owner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              child: Icon(Icons.person),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                "Vampire Prince",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextButton(
              onPressed: () {},
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admins"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              child: Icon(Icons.person),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                "Vampire Prince",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                // later: remove admin logic
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
class WhoCanJoinSheet extends StatefulWidget {
  final String selected;
  final Function(String) onSelect;

  const WhoCanJoinSheet({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  State<WhoCanJoinSheet> createState() => _WhoCanJoinSheetState();
}

class _WhoCanJoinSheetState extends State<WhoCanJoinSheet> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  void select(String value) {
    setState(() {
      selected = value;
    });

    widget.onSelect(value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        RadioListTile(
          title: const Text("Everyone"),
          value: "Everyone",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),
        RadioListTile(
          title: const Text("Family Members Only"),
          value: "Family Members Only",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),

        RadioListTile(
          title: const Text("Followers Only"),
          value: "Followers",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),

        RadioListTile(
          title: const Text("Room Elites"),
          value: "Room Elites",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),
      ],
    );
  }
}
class WhoCanBeSeatedSheet extends StatefulWidget {
  final String selected;
  final Function(String) onSelect;

  const WhoCanBeSeatedSheet({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  State<WhoCanBeSeatedSheet> createState() => _WhoCanBeSeatedSheetState();
}

class _WhoCanBeSeatedSheetState extends State<WhoCanBeSeatedSheet> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  void select(String value) {
    setState(() {
      selected = value;
    });

    widget.onSelect(value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        RadioListTile(
          title: const Text("Everyone"),
          value: "Everyone",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),

        RadioListTile(
          title: const Text("Family Members Only"),
          value: "Family Members",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),

        RadioListTile(
          title: const Text("Room Elites"),
          value: "Room Elites",
          groupValue: selected,
          onChanged: (value) => select(value!),
        ),
      ],
    );
  }
}
class BlockListSheet extends StatefulWidget {
  const BlockListSheet({super.key});

  @override
  State<BlockListSheet> createState() => _BlockListSheetState();
}

class _BlockListSheetState extends State<BlockListSheet> {
  List<String> blockedUsers = [
    "User 1",
    "User 2",
    "User 3",
  ];

  void unblock(String user) {
    setState(() {
      blockedUsers.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40), // 👈 same as others
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Block List",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// LIST
          Expanded(
            child: blockedUsers.isEmpty
                ? const Center(
              child: Text("No blocked users"),
            )
                : ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final user = blockedUsers[index];

                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(user),
                  trailing: TextButton(
                    onPressed: () => unblock(user),
                    child: const Text(
                      "Unblock",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

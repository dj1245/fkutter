  import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sing_verse_app/features/room/presentation/screens//room_screen.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController roomNameController = TextEditingController();

  String privacy = "Public";
  bool agree = false;

  XFile? roomImage;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        roomImage = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          SafeArea(
            child: Column(
              children: [

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Center(
                            child: GestureDetector(
                              onTap: pickImage,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white24,
                                backgroundImage: roomImage != null
                                    ? FileImage(File(roomImage!.path))
                                    : null,
                                child: roomImage == null
                                    ? const Icon(Icons.add_a_photo,
                                    color: Colors.white, size: 30)
                                    : null,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "Room Name",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            controller: roomNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter room name",
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "Privacy",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),

                          _privacyTile("Public"),
                          _privacyTile("Private"),
                          _privacyTile("Friends"),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Checkbox(
                                value: agree,
                                onChanged: (val) {
                                  setState(() {
                                    agree = val ?? false;
                                  });
                                },
                                activeColor: Colors.orange,
                              ),
                              const Expanded(
                                child: Text(
                                  "By creating a room you agree to the Room Agreement, Terms & Conditions and community rules.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (agree &&
                          roomNameController.text.isNotEmpty &&
                          roomImage != null)
                          ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const
                          RoomScreen(),
                          ),
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Create Room"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _privacyTile(String title) {
    return RadioListTile(
      value: title,
      groupValue: privacy,
      onChanged: (value) {
        setState(() {
          privacy = value.toString();
        });
      },
      title: Text(title, style: const TextStyle(color: Colors.white)),
      activeColor: Colors.orange,
    );
  }
}
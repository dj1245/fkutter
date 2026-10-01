import 'package:flutter/material.dart';
import 'package:sing_verse_app/core/utils/double_back_exit.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController =
  TextEditingController(text: "User Name");

  final TextEditingController bioController =
  TextEditingController(text: "Singer | Music Lover 🎤");

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
      backgroundColor: const Color(0xff0b0a1f),

      appBar: AppBar(
        backgroundColor: const Color(0xff1a1440),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.pinkAccent),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            // PROFILE IMAGE
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 30),

            // NAME FIELD
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // BIO FIELD
            TextField(
              controller: bioController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
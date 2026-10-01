import 'package:flutter/material.dart';

class UserProfileMenuBottomSheet extends StatelessWidget {
  final VoidCallback onViewProfile;
  final VoidCallback onLeave;
  final VoidCallback onSendGift;
  final VoidCallback onMute;

  const UserProfileMenuBottomSheet({
    super.key,
    required this.onViewProfile,
    required this.onLeave,
    required this.onSendGift,
    required this.onMute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text(
              "View Profile",
              style: TextStyle(color: Colors.white),
            ),
            onTap: onViewProfile,
          ),

          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            title: const Text(
              "Leave",
              style: TextStyle(color: Colors.white),
            ),
            onTap: onLeave,
          ),

          ListTile(
            leading: const Icon(Icons.card_giftcard, color: Colors.white),
            title: const Text(
              "Send Gift",
              style: TextStyle(color: Colors.white),
            ),
            onTap: onSendGift,
          ),

          ListTile(
            leading: const Icon(Icons.volume_off, color: Colors.white),
            title: const Text(
              "Mute",
              style: TextStyle(color: Colors.white),
            ),
            onTap: onMute,
          ),

        ],
      ),
    );
  }
}
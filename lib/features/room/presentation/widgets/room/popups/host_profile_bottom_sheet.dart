import 'package:flutter/material.dart';

class HostProfileBottomSheet extends StatelessWidget {
  final VoidCallback onViewProfile;
  final VoidCallback onSendGift;
  final VoidCallback onLeave;

  const HostProfileBottomSheet({
    super.key,
    required this.onViewProfile,
    required this.onSendGift,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 25),
        decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // 🔹 drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // 👤 VIEW PROFILE
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                "View Profile",
                style: TextStyle(color: Colors.white),
              ),
              onTap: onViewProfile,
            ),

            // 🎁 SEND GIFT
            ListTile(
              leading: const Icon(Icons.card_giftcard, color: Colors.white),
              title: const Text(
                "Send Gift",
                style: TextStyle(color: Colors.white),
              ),
              onTap: onSendGift,
            ),

            // 🚪 LEAVE
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white),
              title: const Text(
                "Leave",
                style: TextStyle(color: Colors.white),
              ),
              onTap: onLeave,
            ),
          ],
        ),
      ),
    );
  }
}
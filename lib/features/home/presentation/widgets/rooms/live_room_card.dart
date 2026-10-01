import 'package:flutter/material.dart';

class LiveRoomCard extends StatelessWidget {
  final int users;
  final VoidCallback onTap;

  const LiveRoomCard({
    super.key,
    required this.users,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text("$users users"),
        ),
      ),
    );
  }
}
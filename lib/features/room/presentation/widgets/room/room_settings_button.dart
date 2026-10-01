import 'package:flutter/material.dart';

class RoomSettingsButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  final double right;
  final double bottom;

  const RoomSettingsButton({
    super.key,
    required this.onTap,
    this.size = 26,
    this.right = 12,
    this.bottom = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35), // ✔ fixed deprecation
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(
            Icons.list_outlined,
            color: Colors.white,
            size: size,
          ),
        ),
      ),
    );
  }
}
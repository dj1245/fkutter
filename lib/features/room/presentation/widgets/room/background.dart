import 'package:flutter/material.dart';

class RoomBackground {
  static BoxDecoration get() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          // 🌟 FIX: Status bar contrast layer (IMPORTANT)
          Color(0xFF0A0A0A),

          Color(0xFF1A0F0A), // top dark brown
          Color(0xFF3B2A1A), // mid brown
          Color(0xFF0F0A06), // warm brown
          Color(0xFF0B0706), // bottom dark
        ],
      ),
    );
  }
}
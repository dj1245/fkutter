import 'package:flutter/material.dart';

class LiveAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isLive;

  const LiveAvatar({
    super.key,
    required this.imageUrl,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(imageUrl),
        ),

        // LIVE badge
        if (isLive)
          Positioned(
            bottom: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "LIVE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
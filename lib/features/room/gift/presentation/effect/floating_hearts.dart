import 'dart:math';
import 'package:flutter/material.dart';

class FloatingHearts extends StatefulWidget {
  const FloatingHearts({super.key});

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  final List<Offset> positions = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // generate hearts positions
    for (int i = 0; i < 12; i++) {
      positions.add(
        Offset(
          random.nextDouble(),
          random.nextDouble(),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          children: List.generate(positions.length, (index) {
            final pos = positions[index];

            return Positioned(
              left: pos.dx * MediaQuery.of(context).size.width,
              bottom: (pos.dy * 400) + (controller.value * 200),

              child: Opacity(
                opacity: 1 - controller.value,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent,
                  size: 18,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
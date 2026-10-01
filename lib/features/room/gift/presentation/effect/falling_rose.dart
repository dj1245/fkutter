import 'dart:math';
import 'package:flutter/material.dart';

class FallingRoses extends StatefulWidget {
  const FallingRoses({super.key});

  @override
  State<FallingRoses> createState() => _FallingRosesState();
}

class _FallingRosesState extends State<FallingRoses>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  final Random random = Random();

  final List<_Rose> roses = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // 🌹 generate roses
    for (int i = 0; i < 18; i++) {
      roses.add(
        _Rose(
          x: random.nextDouble(),
          delay: random.nextDouble(),
          speed: 0.5 + random.nextDouble(),
          size: 14 + random.nextInt(10),
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
    final height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          children: roses.map((rose) {
            final progress = (controller.value + rose.delay) % 1;

            return Positioned(
              left: rose.x * MediaQuery.of(context).size.width,
              top: progress * height * rose.speed,

              child: Opacity(
                opacity: (1 - progress).clamp(0.0, 1.0),
                child: Icon(
                  Icons.local_florist,
                  color: Colors.pinkAccent,
                  size: rose.size.toDouble(),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _Rose {
  final double x;
  final double delay;
  final double speed;
  final int size;

  _Rose({
    required this.x,
    required this.delay,
    required this.speed,
    required this.size,
  });
}
import 'dart:math';
import 'package:flutter/material.dart';

class KissEffect extends StatefulWidget {
  const KissEffect({super.key});

  @override
  State<KissEffect> createState() => _KissEffectState();
}

class _KissEffectState extends State<KissEffect>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnim;
  late Animation<double> opacityAnim;
  late Animation<double> rotateAnim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    scaleAnim = Tween(begin: 0.2, end: 1.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );

    opacityAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    rotateAnim = Tween(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) Navigator.pop(context);
    });
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
        return Center(
          child: Opacity(
            opacity: opacityAnim.value,
            child: Transform.rotate(
              angle: rotateAnim.value,
              child: Transform.scale(
                scale: scaleAnim.value,
                child: const Text(
                  "💋💋",
                  style: TextStyle(fontSize: 90),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
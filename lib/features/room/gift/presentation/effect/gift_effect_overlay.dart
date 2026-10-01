import 'dart:async';
import 'package:flutter/material.dart';
import 'floating_hearts.dart';
import 'falling_rose.dart';
import 'kiss_effect.dart';
class GiftEffectOverlay extends StatefulWidget {
  final String giftImage;
  final String giftName;

  const GiftEffectOverlay({
    super.key,
    required this.giftImage,
    required this.giftName,
  });

  @override
  State<GiftEffectOverlay> createState() => _GiftEffectOverlayState();
}

class _GiftEffectOverlayState extends State<GiftEffectOverlay>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnim;
  late Animation<double> opacityAnim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    scaleAnim = Tween(begin: 0.2, end: 1.6).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    opacityAnim = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();

    Timer(const Duration(milliseconds: 1400), () {
      if (mounted) Navigator.pop(context);
    });
  }

  /// 🎯 Smart effect selector
  Widget buildEffect() {
    switch (widget.giftName.toLowerCase()) {

      case "heart":
        return const FloatingHearts();

      case "rose":
        return const FallingRoses();

      case "kiss":
        return const KissEffect();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return Opacity(
              opacity: opacityAnim.value,
              child: Transform.scale(
                scale: scaleAnim.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(widget.giftImage, width: 200),
                    buildEffect(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
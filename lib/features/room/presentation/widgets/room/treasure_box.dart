import 'package:flutter/material.dart';

class TreasureBox extends StatefulWidget {
  final bool visible;

  const TreasureBox({
    super.key,
    required this.visible,
  });

  @override
  State<TreasureBox> createState() => _TreasureBoxState();
}

class _TreasureBoxState extends State<TreasureBox> {
  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox();

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.bounceOut,
      tween: Tween<double>(
        begin: -300,
        end: 0,
      ),
      builder: (context, value, child) {
        return Center(
          child: Transform.translate(
            offset: Offset(0, value),
            child: child,
          ),
        );
      },
      child: Image.asset(
        'assets/images/treasure_box.png',
        width: 160,
        height: 160,
      ),
    );
  }
}
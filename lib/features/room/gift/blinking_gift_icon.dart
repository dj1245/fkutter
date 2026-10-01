import 'package:flutter/material.dart';

class BlinkingGiftIcon extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const BlinkingGiftIcon({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<BlinkingGiftIcon> createState() => _BlinkingGiftIconState();
}

class _BlinkingGiftIconState extends State<BlinkingGiftIcon>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glow = Tween<double>(begin: 0.2, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(_glow.value),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: widget.child, // 👈 your original gift icon
            ),
          ),
        );
      },
    );
  }
}
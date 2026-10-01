import 'package:flutter/material.dart';

class DoubleBackExit extends StatefulWidget {
  final Widget child;
  const DoubleBackExit({super.key, required this.child});

  @override
  State<DoubleBackExit> createState() => _DoubleBackExitState();
}

class _DoubleBackExitState extends State<DoubleBackExit> {
  DateTime? lastPressed;

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();

    if (lastPressed == null ||
        now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Press again to exit")),
      );

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: widget.child,
    );
  }
}
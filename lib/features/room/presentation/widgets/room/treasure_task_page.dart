import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/room/application/gift_task_controller.dart';

class TreasureTaskPage extends StatefulWidget {
  final GiftTaskController controller;

  const TreasureTaskPage({
    super.key,
    required this.controller,
  });

  @override
  State<TreasureTaskPage> createState() => _TreasureTaskPageState();
}

class _TreasureTaskPageState extends State<TreasureTaskPage> {
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Scaffold(
      backgroundColor: const Color(0xFF6A0000),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2D004D),
              Color(0xFF3D0000),
              Color(0xFF6A0000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(height: 10),

                    const Text(
                      "Task Progress",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(color: Colors.black38, blurRadius: 5)
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CURRENT TASK CARD
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFD4670E),
                              Color(0xFFE07810),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Column(
                          children: [

                            const Text(
                              "Love Bite",
                              style: TextStyle(
                                color: Color(0xFFFFD966),
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: 0,
                                    minHeight: 12,
                                    backgroundColor: Colors.black26,
                                    valueColor: const AlwaysStoppedAnimation(
                                      Color(0xFFFF6600),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  controller.progressText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "You need 250 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Image.asset(
                                  "assets/images/gift_250.png",
                                  width: 40,
                                  height: 40,
                                ),
                                const Text(
                                  " to open the chest.",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 240,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.18),
                                  Colors.orange.withOpacity(0.05),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                            ),
                         child:  Image.asset(
                            "assets/images/treasure_box.png",
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                      ),
                          ),
                      ],
                    ),
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      "Treasure Box",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
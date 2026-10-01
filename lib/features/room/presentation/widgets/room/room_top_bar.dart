import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/room/application/gift_task_controller.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/treasure_task_page.dart';
class RoomTopBar extends StatelessWidget {
  final VoidCallback onClose;

  // 👉 controller se inject hoga later
  final String giftImage;
  final String giftProgress;
  final GiftTaskController controller;

  const RoomTopBar({
    super.key,
    required this.onClose,
    required this.controller,
    this.giftImage = 'assets/images/gift_250.png',
    this.giftProgress = '0 / 250',
  });

  // ⭐ ADJUST FROM HERE
  static const double rankingTopSpacing = 8;
  static const double rankingLeftPadding = 8;

  // 🎁 GIFT SETTINGS
  static const double giftBoxSize = 40;
  static const double giftSpacing = 14;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TOP ROW
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [

              /// LEFT INFO BOX
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffb026ff), Color(0xff6a00ff)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Lv5",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Text(
                      "Vampires World",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.15)),
                      ),
                      child: const Text(
                        "Mode",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// ONLINE
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.greenAccent.withOpacity(0.35)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.greenAccent),
                    SizedBox(width: 5),
                    Text("12",
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
              ),

              const Spacer(),

              const Icon(Icons.reply_all, color: Colors.white, size: 22),
              const SizedBox(width: 12),

              GestureDetector(
                onTap: onClose,
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),

        /// ⭐ RANKING + GIFT ROW
        Padding(
          padding: const EdgeInsets.only(
            left: rankingLeftPadding,
            top: rankingTopSpacing,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🎁 GIFT BOX (NOW DYNAMIC)
              Container(
                width: giftBoxSize,
                height: giftBoxSize + 14,
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                 GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                      (_) => TreasureTaskPage(controller: controller),
                      ),
                      );
                    },
            child: Image.asset( giftImage,
            ),
                 ),
                    const SizedBox(height: 0),

                    Text(
                      giftProgress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

             const SizedBox(width: giftSpacing),

              /// 🏆 RANKING BUTTON
              GestureDetector(
                onTap: () {
                  print("Ranking clicked");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.transparent.withOpacity(0.15)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.amber, size: 16),
                      SizedBox(width: 5),
                      Text(
                        "Ranking",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
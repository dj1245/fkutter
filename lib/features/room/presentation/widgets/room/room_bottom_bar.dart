import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sing_verse_app/features/room/gift/presentation/gift_panel.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/room_settings_sheet.dart';

class RoomBottomBar extends StatefulWidget {
  final Function(File?)? onCoverSelected;
  final Function(File?)? onBackgroundSelected;
  final Function(String)? onAnnouncementChanged;
  final Function(String giftName, int quantity)? onGiftsent;
  final bool isMicOn;
  final int? mySeatIndex;
  final bool isHostActive;
  final VoidCallback onMicToggle;
  final Function(String) onSendComment;
  final VoidCallback onOpenComment;

  final double iconSize;
  final double spacing;
  final double bottomPadding;
  final double rightPadding;

  final double giftOffsetX;
  final double giftOffsetY;
  final double settingsOffsetX;
  final double settingsOffsetY;
  const RoomBottomBar({
    super.key,
    this.onCoverSelected,
    this.onBackgroundSelected,
    this.onAnnouncementChanged,
    this.onGiftsent,
    required this.isMicOn,
    required this.mySeatIndex,
    required this.isHostActive,
    required this.onMicToggle,
    required this.onSendComment,
    required this.onOpenComment,
    this.iconSize = 35,
    this.spacing = 10,
    this.bottomPadding = 10,
    this.rightPadding = 10,
    this.giftOffsetX = 0,
    this.giftOffsetY = 0,
    this.settingsOffsetX = 0,
    this.settingsOffsetY = 0,

  });

  @override
  State<RoomBottomBar> createState() => _RoomBottomBarState();
}

class _RoomBottomBarState extends State<RoomBottomBar>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    commentController.dispose();
    super.dispose();
  }

  /// 🎁 Gift Panel
  void _openGiftPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => GiftPanel(
        onGiftsent: widget.onGiftsent,
      ),
    );
  }

  /// ⚙️ Settings Panel (FIXED)
  void _openSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RoomSettingBottomSheet(
          onCoverSelected: widget.onCoverSelected ?? (_) {},
        onBackgroundSelected: widget.onBackgroundSelected ?? (_) {},
        onAnnouncementChanged: widget.onAnnouncementChanged ?? (_) {}
      ),
    );
  }

  Widget _roundIcon({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showMic =
        widget.mySeatIndex != null || widget.isHostActive;

    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: widget.rightPadding,
        bottom: widget.bottomPadding,
      ),
      child: Row(
        children: [

          /// 💬 COMMENT
          GestureDetector(
            onTap: widget.onOpenComment,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/comment.svg",
                  width: 25,
                  height: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: widget.spacing),

          /// 🎤 MIC
          if (showMic)
            GestureDetector(
              onTap: widget.onMicToggle,
              child: _roundIcon(
                child: Icon(
                  widget.isMicOn ? Icons.mic : Icons.mic_off,
                  color: Colors.white,
                  size: widget.iconSize * 0.7,
                ),
              ),
            ),

          const Spacer(),

          /// ⚙️ SETTINGS
          Transform.translate(
            offset: Offset(
              widget.settingsOffsetX,
              widget.settingsOffsetY,
            ),
            child: GestureDetector(
              onTap: _openSettings,
              child: _roundIcon(
                child: Icon(
                  Icons.widgets_outlined,
                  color: Colors.white,
                  size: widget.iconSize * 0.8,
                ),
              ),
            ),
          ),

          SizedBox(width: widget.spacing),

          /// 🎁 GIFT
          Transform.translate(
            offset: Offset(
              widget.giftOffsetX,
              widget.giftOffsetY,
            ),
            child: GestureDetector(
              onTap: _openGiftPanel,
              child: _roundIcon(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final scale = 0.95 + (_controller.value * 0.15);

                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/gift.svg",
                    width: widget.iconSize * 0.9,
                    height: widget.iconSize * 0.9,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
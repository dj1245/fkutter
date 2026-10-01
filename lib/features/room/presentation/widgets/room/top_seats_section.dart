import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/room/domain/models/seat_model.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/popups/host_profile_bottom_sheet.dart';

class TopSeatsSection extends StatelessWidget {
  final Seat hostSeat;
  final Seat coHostSeat;
  final Function(int) onTakeSeat;
  final Function(int) onLeaveSeat;

  const TopSeatsSection({
    super.key,
    required this.hostSeat,
    required this.coHostSeat,
    required this.onTakeSeat,
    required this.onLeaveSeat,
  });

  void _showHostSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) {
        return HostProfileBottomSheet(
          onViewProfile: () => Navigator.pop(context),
          onSendGift: () => Navigator.pop(context),

          // 🔥 FIXED LEAVE LOGIC
          onLeave: () {
            Navigator.pop(context);
            onLeaveSeat(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // 👑 HOST
        Positioned(
          left: 98,
          top: 45,
          child: GestureDetector(
            onTap: () {
              if (!hostSeat.occupied) {
                onTakeSeat(8);
              } else {
                _showHostSheet(context, 8);
              }
            },
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ),

        // 🎤 CO-HOST
        Positioned(
          left: 199,
          top: 45,
          child: GestureDetector(
            onTap: () {
              if (!coHostSeat.occupied) {
                onTakeSeat(9);
              } else {
                _showHostSheet(context, 9);
              }
            },
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
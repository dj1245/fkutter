import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/room/domain/models/seat_model.dart';

class SeatMenuBottomSheet extends StatelessWidget {
  final int seatIndex;
  final Seat seat;

  final VoidCallback onTakeSeat;
  final VoidCallback onLockSeat;
  final VoidCallback onOpenSeat;
  final VoidCallback onInvite;
  final Function(int) onLeaveSeat;

  const SeatMenuBottomSheet({
    super.key,
    required this.seatIndex,
    required this.seat,
    required this.onTakeSeat,
    required this.onLockSeat,
    required this.onOpenSeat,
    required this.onInvite,
    required this.onLeaveSeat,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 25),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // 🔹 TOP DRAG HANDLE (slide sheet indicator)
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // 🪑 TAKE SEAT
            ListTile(
              leading: const Icon(Icons.event_seat, color: Colors.white),
              title: const Text(
                "Take Seat",
                style: TextStyle(color: Colors.white),
              ),
              onTap: onTakeSeat,
            ),

            // 🔒 LOCK SEAT
            if (!seat.locked)
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.white),
                title: const Text(
                  "Lock Seat",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: onLockSeat,
              ),

            // 🔓 OPEN SEAT
            if (seat.locked)
              ListTile(
                leading: const Icon(Icons.lock_open, color: Colors.white),
                title: const Text(
                  "Open Seat",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: onOpenSeat,
              ),

            // 👥 INVITE
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.white),
              title: const Text(
                "Invite",
                style: TextStyle(color: Colors.white),
              ),
              onTap: onInvite,
            ),

            // 🚪 LEAVE SEAT
            if (seat.occupied)
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text(
                  "Leave Seat",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => onLeaveSeat(seatIndex),
              ),
          ],
        ),
      ),
    );
  }
}
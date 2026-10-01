import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/room/domain/models/seat_model.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/popups/seat_menu_bottom_sheet.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/popups/user_profile_menu_bottom_sheet.dart';

class RoomSeatsSection extends StatelessWidget {
  final List<Seat> seats;
  final Function(int) onTakeSeat;
  final Function(int) onLeaveSeat;
  final Function(int) onLockSeat;
  final Function(int) onOpenSeat;

  const RoomSeatsSection({
    super.key,
    required this.seats,
    required this.onTakeSeat,
    required this.onLeaveSeat,
    required this.onLockSeat,
    required this.onOpenSeat,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(8, (index) {
        final seat = seats[index];

        int col = index % 4;
        int row = index ~/ 4;

        double left = 24 + col * 85;
        double top = 150 + row * 105;

        return Positioned(
          left: left,
          top: top,
          child: GestureDetector(
            onTap: () {

              // 👤 USER SEAT
              if (seat.occupied) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  builder: (_) {
                    return FractionallySizedBox(
                      heightFactor: 0.35,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: UserProfileMenuBottomSheet(
                          onViewProfile: () {
                            Navigator.pop(context);
                          },
                          onLeave: () {
                            Navigator.pop(context);
                            onLeaveSeat(index);
                          },
                          onSendGift: () {
                            Navigator.pop(context);
                          },
                          onMute: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              }

              // 🪑 EMPTY SEAT  ✅ FIXED (NOW SLIDE UP SHEET)
              else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.black54,
                  builder: (_) {
                    return SeatMenuBottomSheet(
                      seatIndex: index,
                      seat: seat,

                      onTakeSeat: () {
                        Navigator.pop(context);
                        onTakeSeat(index);
                      },

                      onLockSeat: () {
                        Navigator.pop(context);
                        onLockSeat(index);
                      },

                      onOpenSeat: () {
                        Navigator.pop(context);
                        onOpenSeat(index);
                      },

                      onInvite: () {
                        Navigator.pop(context);
                      },

                      onLeaveSeat: (_) {
                        Navigator.pop(context);
                        onLeaveSeat(index);
                      },
                    );
                  },
                );
              }
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    seat.locked
                        ? Icons.lock
                        : seat.occupied
                        ? Icons.person
                        : Icons.mic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  seat.occupied ? seat.userName : "Seat ${index + 1}",
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
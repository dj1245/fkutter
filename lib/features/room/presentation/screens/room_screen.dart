import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/room_top_bar.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/comment_overlay.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/room_bottom_bar.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/room_seats_section.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/top_seats_section.dart';
import 'package:sing_verse_app/features/room/domain/models/seat_model.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/background.dart';
import 'package:sing_verse_app/features/room/presentation/widgets/room/treasure_box.dart';
import 'package:sing_verse_app/features/room/application/gift_task_controller.dart';
import 'package:sing_verse_app/features/room/domain/models/gift_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comment {
  final String name;
  final String text;
  final String image;

  Comment({
    required this.name,
    required this.text,
    required this.image,
  });
}

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isMicOn = true;
  String currentUserName = "Me";
  int? mySeatIndex;
  bool isInAnySeat = false;
  File? roomBackground;
  File? coverImage;
  String roomAnnouncement = "";
    Future<void> loadAnnouncement() async {
      final prefs = await SharedPreferences.getInstance();
      final text =
     prefs.getString('room_announcement') ?? "";
      setState(() {
        roomAnnouncement = text;
      });
    }

  void updateBackground(File ? file) {
    setState(() {
      roomBackground = file;
    });
  }

  void updateCover(File ? file) {
    setState(() {
      coverImage = file;
    });
  }
Future<void> updateAnnouncement(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('room_announcement',text);
    setState(() {
      roomAnnouncement = text;
    });
}
Future<void> showTreasureDrop() async {
      setState(() {
        showTreasure = true;
      });
      await Future.delayed( const Duration(seconds: 3),
      );
      if(!mounted) return;
      setState(() {
        showTreasure = false;
      });
      }


  /// 💎 TREASURE BOX STATE
  bool showTreasure = false;

  /// 🎯 CONTROLLER (TASK SYSTEM)
  final GiftTaskController controller = GiftTaskController();
  List<Comment> comments = [
    Comment(
      name: "Ali",
      text: "Hello 👋",
      image: "https://i.pravatar.cc/150?img=1",
    ),
    Comment(
      name: "Sara",
      text: "Nice room 🔥",
      image: "https://i.pravatar.cc/150?img=2",
    ),
  ];

  List<Seat> seats = List.generate(
    10,
        (i) => Seat(
      occupied: false,
      locked: false,
      userName: "",
    ),
  );
  @override
  void initState() {
    super.initState();
    loadAnnouncement();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );
    });
  }

  void sendComment(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      comments.add( Comment(
          name: currentUserName,
          text: text.trim(),
          image: "https://i.pravatar.cc/150?img=5",
        ),
      );
    });
  }

  void openCommentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentOverlay(
        onSend: (text) => sendComment(text),
      ),
    );
  }

  /// 🎁 TEST GIFT FUNCTION (later real gifts yahan aayenge)
  void addGift(int amount) {
    setState(() {
      controller.addGift(amount, onComplete: () {
        showTreasureDrop();
      },
      );
    });
  }



  void takeSeat(int index) {
    setState(() {
      seats[index].locked = false;

      for (int i = 0; i < seats.length; i++) {
        if (seats[i].userName == currentUserName) {
          seats[i].occupied = false;
          seats[i].userName = "";
        }
      }

      seats[index].occupied = true;
      seats[index].userName = currentUserName;

      mySeatIndex = index;
      isInAnySeat = true;
    });
  }

  void leaveSeat(int index) {
    setState(() {
      seats[index].occupied = false;
      seats[index].userName = "";
      mySeatIndex = null;
      isInAnySeat = false;
    });
  }

  void toggleLock(int index) {
    setState(() {
      seats[index].locked = !seats[index].locked;
    });
  }

  void openSeat(int index) {
    setState(() {
      seats[index].locked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [

          /// 🌄 BACKGROUND
         AnimatedContainer(
           duration: const Duration(milliseconds: 300),
            decoration: roomBackground != null ? BoxDecoration(
     image: DecorationImage( image: FileImage
            (roomBackground!), fit: BoxFit.cover,
          ),

          )
          : RoomBackground.get(),
          ),
          /// 🌫 TOP GRADIENT
          Container(
            height: topPadding + 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          /// 📦 TREASURE BOX OVERLAY
          TreasureBox(visible: showTreasure),

          /// 📱 MAIN UI
          SafeArea(
            child: Column(
              children: [

                /// TOP BAR (DYNAMIC)
                RoomTopBar(
                  onClose: () => Navigator.pop(context),
                  controller: controller,
                  giftImage: controller.currentTask.iconPath,
                  giftProgress: controller.progressText,
                ),

                const SizedBox(height: 10),

                /// MAIN CONTENT
                Expanded(
                  child: Stack(
                    children: [

                      /// SEATS
                      Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                TopSeatsSection(
                                  hostSeat: seats[8],
                                  coHostSeat: seats[9],
                                  onTakeSeat: takeSeat,
                                  onLeaveSeat: leaveSeat,
                                ),
                                RoomSeatsSection(
                                  seats: seats,
                                  onTakeSeat: takeSeat,
                                  onLeaveSeat: leaveSeat,
                                  onLockSeat: toggleLock,
                                  onOpenSeat: openSeat,
                                ),
                              ],
                            ),
                          ),

                          /// COMMENTS
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 260,
                                child: ListView.builder(
                                  reverse: true,
                                  padding: const EdgeInsets.only(left: 28, right: 60),
                                  itemCount: comments.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == comments.length) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            /// OUTSIDE ICON (like DP)
                                            Container(
                                              margin: const EdgeInsets.only(right: 2),
                                              child: Transform.translate(offset:
                                                  const Offset(-25, 0),
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.orange,
                                                child: const Icon(
                                                  Icons.campaign,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            ),

                                            /// MESSAGE BOX
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent.withOpacity(0.05),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  roomAnnouncement,
                                                  style: const TextStyle(
                                                    color: Colors.cyanAccent,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    final comment = comments[comments.length
                                    - 1 - index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Transform.translate(
                                            offset: const Offset(-10, 0),
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundImage:
                                              NetworkImage(comment.image),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.02),
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  ),
                                                  child: Text(
                                                    comment.text,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// BOTTOM BAR
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    top: false,
                    child: RoomBottomBar(
                      isMicOn: isMicOn,
                      mySeatIndex: mySeatIndex,
                      isHostActive: isInAnySeat,
                      onMicToggle: () {
                        setState(() => isMicOn = !isMicOn);
                      },
                      onSendComment: sendComment,
                      onOpenComment: openCommentSheet,
                      onCoverSelected: updateCover,
                      onBackgroundSelected: updateBackground,
                      onAnnouncementChanged:
                        updateAnnouncement,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
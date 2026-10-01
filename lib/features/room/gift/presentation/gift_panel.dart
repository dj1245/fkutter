import 'package:flutter/material.dart';
import 'package:sing_verse_app/features/room/gift/presentation/data/gifts_data.dart';
import 'package:sing_verse_app/features/room/gift/presentation/data/user_data.dart';
import 'package:sing_verse_app/core/mock_wallet.dart';
import 'package:sing_verse_app/features/room/gift/presentation/effect/gift_effect_overlay.dart';
class GiftPanel extends StatefulWidget {
  final Function(String giftName, int quantity) ? onGiftsent;
  const GiftPanel({
    super.key,
    this.onGiftsent,

  });

  @override
  State<GiftPanel> createState() => _GiftPanelState();
}

class _GiftPanelState extends State<GiftPanel> {
  bool isTestMode = true;
  int selectedUserIndex = -1;
  int selectedGiftIndex = -1;
  int selectedCategory = 0;
  int quantity = 1;
  int loveBiteProgress = 0;
  int bloodDropProgress = 0;
  int batProgress = 0;
  bool bloodDropUnlocked = false;
  bool batUnlocked = false;



  List get users => UsersData.users;
  List<Map<String, dynamic>> get gifts => GiftsData.gifts;

  final List<String> categories = [
    "Gift",
    "Lucky",
    "Special",
    "Couple",
    "Backpack",
  ];
  void sendGift() {
    if (selectedGiftIndex == -1 || selectedUserIndex == -1) {
      return;
    }
    void openTreasureBox() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.card_giftcard,
                  size: 70,
                  color: Colors.amber,
                ),
                SizedBox(height: 12),
                Text(
                  "Treasure Box Opened!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    final gift = gifts[selectedGiftIndex];
    if (gift["name"] == "Love Bite") {
      loveBiteProgress += quantity;

      if (loveBiteProgress >= 250) {
        loveBiteProgress = 250;
        bloodDropUnlocked = true;
      }
    }

    else if (gift["name"] == "Blood Drop") {
      if (!bloodDropUnlocked) return;

      bloodDropProgress += quantity;

      if (bloodDropProgress >= 150) {
        bloodDropProgress = 150;
        batUnlocked = true;
      }
    }

    else if (gift["name"] == "Bat") {
      if (!batUnlocked) return;

      batProgress += quantity;

      if (batProgress >= 100) {
        batProgress = 100;

        Future.delayed(const Duration(milliseconds: 500), () {
          openTreasureBox();
        });
      }
    }
    final user = users[selectedUserIndex];

    final int price = gift["value"]; // gift price
    final int totalCost = price * quantity;

    // ❌ coins check
    if (!isTestMode && MockWallet.coins < totalCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Not enough coins")),
      );
      return;
    }

    // 💰 deduct coins
    MockWallet.coins -= totalCost;

    // 💎 host diamonds (50% earning)
    MockWallet.diamonds += (totalCost * 0.5).toInt();
    widget.onGiftsent?.call(gift["name"],quantity);

    Navigator.pop(context); // close gift panel

    // 🎉 play gift effect
    Future.delayed(const Duration(milliseconds: 200), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => GiftEffectOverlay(
          giftImage: gift["image"],
          giftName: gift["name"],
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Sent ${gift['name']} x$quantity to ${user['name']} 🎁",
        ),
      ),
    );
  }

  Future<void> openQuantitySheet() async {
    final controller =
    TextEditingController(text: quantity.toString());

    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 12,
            right: 12,
            top: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC2185B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      int.tryParse(controller.text) ?? 1,
                    );
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        quantity = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredGifts = selectedCategory == 0
        ? gifts
        : gifts.where((g) {
      return g["category"] == categories[selectedCategory];
    }).toList();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height * 0.54,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Column(
              children: [

                const SizedBox(height: 8),

                Container(
                  width: 45,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 10),

                /// USERS (FIXED)
                SizedBox(
                  height: 78,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final isSelected = selectedUserIndex == index;

                      return GestureDetector(
                        behavior: HitTestBehavior.opaque, // ✅ IMPORTANT FIX
                        onTap: () {
                          setState(() {
                            selectedUserIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.redAccent
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                  NetworkImage(user["img"]),
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  user["name"],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.redAccent
                                        : Colors.white,
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const Divider(color: Colors.white12, height: 14),

                /// CATEGORY
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedCategory == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                            selectedGiftIndex = -1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.redAccent
                                  : Colors.white70,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 0),

                /// GIFTS GRID
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredGifts.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {
                      final gift = filteredGifts[index];
                      final isSelected = selectedGiftIndex == index;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => selectedGiftIndex = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.06)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.redAccent
                                  : Colors.white.withOpacity(0.05),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                gift["image"],
                                height: 48,
                                width: 48,
                              ),
                              const SizedBox(height: 1),
                              Text(
                                gift["name"],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${gift["value"]}",
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// BOTTOM BAR
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
                    child: Row(
                      children: [
                        const Spacer(),

                        Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                            Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                                "$quantity",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: openQuantitySheet,
                                child: const Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              GestureDetector(
                                onTap: sendGift,
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffC2185B),
                                  ),
                                  child: const Text(
                                    "Send",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
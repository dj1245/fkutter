import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: PageView(
        children: [
          banner("assets/banners/banner1.png"),
          banner("assets/banners/banner2.png"),
          banner("assets/banners/banner3.png"),
        ],
      ),
    );
  }

  Widget banner(String img) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(img, fit: BoxFit.cover),
      ),
    );
  }
}
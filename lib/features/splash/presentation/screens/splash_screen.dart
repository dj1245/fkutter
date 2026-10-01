import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double _logoScale = 0.6;
  double _logoOpacity = 0;
  double _textOpacity = 0;
  double _logoTopPadding = 0;

  @override
  void initState() {
    super.initState();

    // Logo zoom + fade
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _logoScale = 1;
        _logoOpacity = 1;
      });
    });

    // Logo thora upar move + text show
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _logoTopPadding = 40;
        _textOpacity = 1;
      });
    });

    // Navigate to login
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 🌈 Premium Gradient Background
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1a002b),
                  Color(0xff3b0066),
                  Color(0xffff4d8d),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🎬 Center Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                AnimatedPadding(
                  duration: const Duration(milliseconds: 700),
                  padding: EdgeInsets.only(top: _logoTopPadding),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _logoOpacity,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 800),
                      scale: _logoScale,
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 140,
                        height: 140,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✨ Tagline Animation
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: _textOpacity,
                  child: const Column(
                    children: [

                      Text(
                        "Sing & Earn",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ⏳ Bottom Loading Indicator
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sing_verse_app/core/utils/double_back_exit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnack("Please fill all fields");
      return;
    }

    if (!email.contains("@")) {
      showSnack("Enter valid email");
      return;
    }

    if (password.length < 6) {
      showSnack("Password must be 6+ characters");
      return;
    }

    Navigator.pushReplacementNamed(context, '/home');
  }

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void socialLogin(String type) async {
    if (type == "Google") {
      try {
        final user = await googleSignIn.signIn();

        if (user != null) {
          showSnack("Welcome ${user.displayName}");

          Navigator.pushNamedAndRemoveUntil(
            context,
            "/home",
                (route) => false,
          );
        } else {
          showSnack("Login cancelled");
        }
      } catch (e) {
        showSnack("Google login failed");
      }
    } else {
      showSnack("$type login clicked");
    }
  }

  Widget socialIcon(String path, String type) {
    return GestureDetector(
      onTap: () => socialLogin(type),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Image.asset(path, width: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
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

          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Image.asset(
                    "assets/images/logo.png",
                    width: 110,
                  ),

                  const SizedBox(height: 20),
                  const SizedBox(height: 35),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Or continue with",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18,
                    runSpacing: 12,
                    children: [
                      socialIcon("assets/images/google.png", "Google"),
                    ],
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
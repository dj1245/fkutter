import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sing_verse_app/core/utils/double_back_exit.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nickController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  String? gender;
  DateTime? dob;

  bool isObscure1 = true;
  bool isObscure2 = true;

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dob = picked;
      });
    }
  }

  void signup() {
    String nick = nickController.text.trim();
    String email = emailController.text.trim();
    String pass = passwordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    if (nick.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        confirmPass.isEmpty ||
        gender == null ||
        dob == null) {
      showSnack("Please fill all fields");
      return;
    }

    if (!email.contains("@")) {
      showSnack("Enter valid email");
      return;
    }

    if (pass.length < 6) {
      showSnack("Password must be 6+ characters");
      return;
    }

    if (pass != confirmPass) {
      showSnack("Passwords do not match");
      return;
    }

    showSnack("OTP sent to email (demo)");
    showOtpDialog();
  }

  void showOtpDialog() {
    TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter OTP"),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                if (otpController.text.length == 4) {
                  showSnack("OTP Verified");

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/home",
                        (route) => false,
                  );
                } else {
                  showSnack("Invalid OTP");
                }
              },
              child: const Text("Verify"),
            ),
          ],
        );
      },
    );
  }

  void signInWithGoogle() async {
    try {
      final user = await googleSignIn.signIn();

      if (user != null) {
        showSnack("Welcome ${user.displayName}");
      } else {
        showSnack("Login cancelled");
      }
    } catch (e) {
      showSnack("Google login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
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
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),

                const SizedBox(height: 25),

                field(nickController, "Nick Name", Icons.person),
                const SizedBox(height: 15),

                field(emailController, "Email", Icons.email),
                const SizedBox(height: 15),

                passwordField(passwordController, "Password", true),
                const SizedBox(height: 15),

                passwordField(confirmPasswordController, "Confirm Password", false),
                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    value: gender,
                    hint: const Text("Select Gender"),
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: ["Male", "Female", "Other"]
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 15),

                GestureDetector(
                  onTap: pickDate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      dob == null
                          ? "Select Date of Birth"
                          : dob.toString().split(" ")[0],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: signup,
                    child: const Text("GET OTP VIA EMAIL"),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialIcon(
                      Image.asset(
                        'assets/images/google.png',
                        height: 24,
                        width: 24,
                      ),
                      signInWithGoogle,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Already have account? Login",
                    style: TextStyle(color: Colors.white),
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

  Widget socialIcon(Widget child, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }

  Widget field(TextEditingController c, String hint, IconData icon) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget passwordField(TextEditingController c, String hint, bool first) {
    bool isObscure = first ? isObscure1 : isObscure2;

    return TextField(
      controller: c,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              if (first) {
                isObscure1 = !isObscure1;
              } else {
                isObscure2 = !isObscure2;
              }
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
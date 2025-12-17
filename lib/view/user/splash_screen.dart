import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machin_task/view/admin/screen/home_screen.dart';
import 'package:machin_task/view/sign_in_screen.dart';
import 'package:machin_task/view/user/student_dash_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), checkUser);
  }

  Future<void> checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      // Logged in → check role
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final role = doc['role'];

      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AdminDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => StudentDashboard()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 59, 65),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // App Logo
            Icon(
              Icons.school,
              size: 90,
              color: Colors.amber,
            ),

            const SizedBox(height: 20),

            // App Name
            const Text(
              "APTCODER EdTech",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            // Tagline
            const Text(
              "Learn • Grow • Succeed",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}

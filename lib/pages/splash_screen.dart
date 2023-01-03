import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/pages/dashboard.dart';
import 'package:zig_project/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), (() {
      final user =
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const Dashboard())));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const LogIn())));
        }
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
            child: Icon(
          Icons.android_sharp,
          size: 150,
        )),
        color: Colors.amber,
      ),
    );
  }
}

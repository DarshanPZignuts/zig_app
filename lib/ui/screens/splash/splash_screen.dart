import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/login/login_screen.dart';
import 'package:zig_project/resources/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), (() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (mounted) {
          if (user != null) {
            Navigator.of(context).pushReplacementNamed(Dashboard.id);
          } else {
            Navigator.pushReplacementNamed(context, LogIn.id);
          }
        }
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetsManager.splaceLogo,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}

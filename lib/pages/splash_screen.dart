import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/pages/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    
    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Dashboard())));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Icon(Icons.android_sharp,size: 150,)),
        color: Colors.amber,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zig_project/ui/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/login/login.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

class DialogBox {
  final Auth _auth = Auth();

  Widget dialogBox(BuildContext context) {
    return AlertDialog(
      title: const Text(StringManager.alertBoxTittle),
      content: const Text(StringManager.alertBoxDescription),
      actions: [
        TextButton(
            onPressed: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                await _auth.signOut();
              }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const LogIn())),
                  (route) => false);
            },
            child: Text(
              "Yes",
              style: TextStyle(color: ColorManager.primary, fontSize: 18),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "No",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            )),
      ],
    );
  }
}

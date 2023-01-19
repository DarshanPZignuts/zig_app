import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/login/login_screen.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

class DialogBox {
  static Widget dialogBox({
    required BuildContext context,
    required Function() onYes,
    required String tittle,
    required String content,
  }) {
    final Auth _auth = Auth();
    return AlertDialog(
      title: Text(tittle),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: onYes,
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

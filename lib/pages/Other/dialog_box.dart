import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/authentication/auth.dart';
import 'package:zig_project/pages/login.dart';

class DialogBox {
  Auth _auth = Auth();

  Widget dialogBox(BuildContext context) {
    return AlertDialog(
      title: Text("Please Confirm!"),
      content: Text("Are sure to sign out from account?"),
      actions: [
        TextButton(
            onPressed: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                await _auth.signOut();
              }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => LogIn())),
                  (route) => false);
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.amber, fontSize: 18),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "No",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            )),
      ],
    );
  }
}

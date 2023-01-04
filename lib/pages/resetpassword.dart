import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Center(
          child: Container(
        child: Column(children: [
          Text("Password reset link will be sent to user inputted email"),
          Container(
            child: TextField(),
          )
        ]),
      )),
    );
  }
}

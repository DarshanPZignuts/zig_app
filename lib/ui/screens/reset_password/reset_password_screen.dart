// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/ui/screens/login/login_screen.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/widgets/widgets.dart';

class ResetPassword extends StatelessWidget {
  static const String id = "ResetPassword";
  ResetPassword({super.key});

  final TextEditingController _emailController = TextEditingController();
  RegExp regemail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(children: [
          Text(
            StringManager.resetPasswordTittle,
            style: TextStyle(color: ColorManager.primary, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringManager.resetPasswordSubTittle,
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(
            height: 100,
          ),
          CommonWidgets.commonTextInputField(
            isPassword: false,
            showConfirmPassword: false,
            obscureText: false,
            showPassword: false,
            label: StringManager.emailLable,
            controller: _emailController,
            validate: (String? val) {
              if (val!.isEmpty) {
                return StringManager.validateEmptyEmail;
              } else if (!regemail.hasMatch(val)) {
                return StringManager.validateEmail;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          CommonWidgets.commonMatrialButton(
              context: context,
              onTap: () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emailController.text.trim());

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text(StringManager.resetPasswordSuccessSnackbar)));
                  Navigator.of(context).pushReplacementNamed(LogIn.id);
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(StringManager.userNotFound)));
                  }
                }
              },
              buttonText: StringManager.sendLinkButtonText)
        ]),
      )),
    );
  }
}

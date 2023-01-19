import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/widgets/common_widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final Auth _auth = Auth();
  bool showPassword = false;
  bool showConfirmPassword = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
            StringManager.changePasswordTitle,
            style: TextStyle(color: ColorManager.primary, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringManager.changePasswordSubTitle,
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(
            height: 100,
          ),
          Column(children: [
            CommonWidgets.commonTextInputField(
              suffixAction: () {
                setState(() {
                  if (showPassword) {
                    showPassword = false;
                  } else {
                    showPassword = true;
                  }
                });
              },
              isPassword: true,
              label: "New password",
              showConfirmPassword: showConfirmPassword,
              showPassword: showPassword,
              controller: _passwordController,
              validate: (String? val) {
                if (val!.isEmpty) {
                  return StringManager.validateEmptyPassword;
                } else if (val.length < 6) {
                  return StringManager.validatePasswordLength;
                } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                  return StringManager.validatePasswordCharacter;
                } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                  return StringManager.validatePasswordNumber;
                }
                return null;
              },
              obscureText: !showPassword,
            ),
            const SizedBox(
              height: 50,
            ),
            CommonWidgets.commonTextInputField(
              suffixAction: () {
                setState(() {
                  if (showConfirmPassword) {
                    showConfirmPassword = false;
                  } else {
                    showConfirmPassword = true;
                  }
                });
              },
              isPassword: true,
              label: "Confirm password",
              showConfirmPassword: showConfirmPassword,
              showPassword: showPassword,
              controller: _confirmPasswordController,
              validate: (String? val) {
                if (val!.isEmpty) {
                  return StringManager.validateEmptyPassword;
                } else if (val.length < 6) {
                  return StringManager.validatePasswordLength;
                } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                  return StringManager.validatePasswordCharacter;
                } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                  return StringManager.validatePasswordNumber;
                }
                return null;
              },
              obscureText: !showConfirmPassword,
            ),
            const SizedBox(
              height: 50,
            ),
          ]),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              final message = await _auth
                  .changePassword(_confirmPasswordController.text.trim());
              if (message != null) {
                //todo
                if (message == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(StringManager.changePasswordSnackbarText)));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const Dashboard())));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text(StringManager.changePasswordErrorSnackbarText)));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ColorManager.primary),
              fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
            ),
            child: const Text(
              StringManager.changePasswordButtonText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ]),
      )),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/login/login.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Auth _auth = Auth();
  bool showPassword = false;
  bool showConfirmPassword = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
        child: Container(
          child: Column(children: [
            Text(
              StringManager.changePasswordTitle,
              style: TextStyle(color: ColorManager.primary, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              StringManager.changePasswordSubTitle,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return StringManager.validateEmptyPassword;
                    } else if (val.length < 6) {
                      return StringManager.validatePasswordLength;
                    } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                      return StringManager.validatePasswordCharacter;
                    } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                      return StringManager.validatePasswordNumber;
                    }
                  },
                  obscureText: !showPassword,
                  decoration:
                      _customInputPasswordDecoration(lable: "New Password"),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _confirmPasswordController,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return StringManager.validateEmptyPassword;
                    } else if (!(val == _passwordController.text)) {
                      return StringManager.validateConfirmPasswordMatch;
                    }
                  },
                  obscureText: !showConfirmPassword,
                  decoration: _customInputPasswordDecoration(
                      lable: "Confirm Password", isConfirmPassword: true),
                ),
                SizedBox(
                  height: 50,
                ),
              ]),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await _auth
                    .changePassword(_confirmPasswordController.text.trim());
                if (message != null) {
                  //todo
                  if (message == "success") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(StringManager.changePasswordSnackbarText)));
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) => Dashboard())));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(StringManager.changePasswordErrorSnackbarText)));
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorManager.primary),
                fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
              ),
              child: const Text(
                StringManager.changePasswordButtonText,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ]),
        ),
      )),
    );
  }

  InputDecoration _customInputPasswordDecoration({
    required String lable,
    bool? isConfirmPassword,
  }) {
    return InputDecoration(
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary),
      ),
      label: Text(lable),
      floatingLabelStyle: TextStyle(color: ColorManager.primary),
      suffixIcon: InkWell(
          onTap: () {
            if (isConfirmPassword == null) {
              setState(() {
                if (showPassword) {
                  showPassword = false;
                } else {
                  showPassword = true;
                }
              });
            } else {
              setState(() {
                if (showConfirmPassword) {
                  showConfirmPassword = false;
                } else {
                  showConfirmPassword = true;
                }
              });
            }
          },
          child: Icon(
              isConfirmPassword == null
                  ? showPassword
                      ? Icons.visibility_off
                      : Icons.visibility
                  : showConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
              color: ColorManager.primary)),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/authentication/auth.dart';
import 'package:zig_project/pages/dashboard.dart';
import 'package:zig_project/pages/login.dart';

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
              "Change Password",
              style: TextStyle(color: Colors.amber, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter a new password",
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
                      return "Password should not be empty";
                    } else if (val.length < 6) {
                      return "Length should be greater or equal to 6 character";
                    } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                      return "Please use characters";
                    } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                      return "Please use Numbers";
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
                      return "Please confirm the password";
                    } else if (!(val == _passwordController.text)) {
                      return "Password not matched";
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
                  if (message == "success") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Password successfully changed.")));
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) => Dashboard())));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong!!")));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
              ),
              child: const Text(
                "Change Password",
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
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amber),
      ),
      label: Text(lable),
      floatingLabelStyle: TextStyle(color: Colors.amber),
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
              color: Colors.amber)),
    );
  }
}

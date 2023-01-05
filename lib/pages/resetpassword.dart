import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/pages/login.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  TextEditingController _emailController = TextEditingController();
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
        child: Container(
          child: Column(children: [
            Text(
              "Reset Password",
              style: TextStyle(color: Colors.amber, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Password reset link will be sent to user inputted email",
              style: TextStyle(color: Colors.grey.shade500),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.7,
                child: _buildInput(
                  label: "Email",
                  controller: _emailController,
                  validate: (String? val) {
                    if (val!.isEmpty || val == null) {
                      return "Email should not be empty.";
                    } else if (!regemail.hasMatch(val)) {
                      return "Please enter Valid email address";
                    }
                  },
                )),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emailController.text.trim());

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Reset link successfully sent to your email.")));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogIn()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email id is not registerd")));
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
              ),
              child: const Text(
                "SEND LINK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ]),
        ),
      )),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    required String? validate(String? s),
  }) {
    return Container(
        height: 80,
        width: 300,
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validate,
              cursorColor: Colors.amber,
              cursorHeight: 20,
              style: TextStyle(color: Colors.amber),
              controller: controller,
              //DECORATION...
              decoration: InputDecoration(
                hintText: "Email",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
            )));
  }
}

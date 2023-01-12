import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/ui/screens/login/login.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

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
              StringManager.resetPasswordTittle,
              style: TextStyle(color: ColorManager.primary, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              StringManager.resetPasswordSubTittle,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.7,
                child: _buildInput(
                  label: StringManager.emailLable,
                  controller: _emailController,
                  validate: (String? val) {
                    if (val!.isEmpty || val == null) {
                      return StringManager.validateEmptyEmail;
                    } else if (!regemail.hasMatch(val)) {
                      return StringManager.validateEmail;
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
                          Text(StringManager.resetPasswordSuccessSnackbar)));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogIn()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(StringManager.userNotFound)));
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorManager.primary),
                fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
              ),
              child: const Text(
                StringManager.sendLinkButtonText,
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
              cursorColor: ColorManager.primary,
              cursorHeight: 20,
              style: TextStyle(color: ColorManager.primary),
              controller: controller,
              //DECORATION...
              decoration: InputDecoration(
                hintText: StringManager.emailHintText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
              ),
            )));
  }
}

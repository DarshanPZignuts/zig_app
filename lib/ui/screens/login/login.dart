import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/login/reset_password.dart';
import 'package:zig_project/ui/screens/signup/signin.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Auth _auth = Auth();
  bool isloading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  RegExp regemail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool showPassword = false;

  Widget _buildInput({
    required String label,
    required bool isPassword,
    required TextEditingController controller,
    required bool obscureText,
    required String? validate(String? s),
    bool? isLastField,
  }) {
    return Container(
        height: 80,
        width: 300,
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              textInputAction: isLastField == null
                  ? TextInputAction.next
                  : TextInputAction.done,
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validate,
              cursorColor: ColorManager.primary,
              cursorHeight: 20,
              style: TextStyle(color: ColorManager.primary),
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            if (showPassword) {
                              showPassword = false;
                            } else {
                              showPassword = true;
                            }
                          });
                        },
                        icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.shade500))
                    : null,
                label: Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.15),
            child: Column(
              children: [
                Image.asset(
                  AssetsManager.splaceLogo,
                  height: 70,
                  width: 70,
                ),
                SizedBox(height: height * 0.1),
                Text(
                  StringManager.loginTittle,
                  style: TextStyle(color: ColorManager.primary, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  StringManager.loginSubTittle,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  child: Column(children: [
                    _buildInput(
                        label: StringManager.emailLable,
                        obscureText: false,
                        isPassword: false,
                        validate: (String? val) {
                          if (val!.isEmpty || val == null) {
                            return StringManager.validateEmptyEmail;
                          } else if (!regemail.hasMatch(val)) {
                            return StringManager.validateEmail;
                          }
                        },
                        controller: _emailcontroller),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildInput(
                        isLastField: true,
                        isPassword: true,
                        label: StringManager.passwordLable,
                        obscureText: !showPassword,
                        validate: (String? val) {
                          if (val!.isEmpty || val == null) {
                            return StringManager.validateEmptyPassword;
                          } else if (val.length <= 6) {
                            return StringManager.validatePasswordLength;
                          } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                            return StringManager.validatePasswordCharacter;
                          } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                            return StringManager.validatePasswordNumber;
                          }
                        },
                        controller: _passwordcontroller),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          StringManager.forgotPasswordText,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 55),
                          child: TextButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPassword()));
                              },
                              child: Text(
                                StringManager.resetButtonText,
                                style: TextStyle(color: ColorManager.primary),
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _formkey.currentState!.activate();
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isloading = true;
                          });

                          final user = await _auth.logInwithEmailandpassword(
                              _emailcontroller.text, _passwordcontroller.text);
//todo
                          if (user == "success") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Dashboard())));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(user.toString())));
                            setState(() {
                              isloading = false;
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorManager.primary),
                        fixedSize: MaterialStatePropertyAll(
                            Size(width * 0.6, height * 0.02)),
                      ),
                      child: isloading
                          ? Container(
                              height: 10,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              StringManager.loginButtonText,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringManager.dontHaveAccountText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) => SignIn())));
                            },
                            child: Text(
                              StringManager.loginCreateAccountButton,
                              style: TextStyle(color: ColorManager.primary),
                            ))
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

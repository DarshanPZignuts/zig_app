import 'package:flutter/material.dart';
import 'package:zig_project/resources/route_manager.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/login/login_screen.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

import 'package:zig_project/ui/widgets/widgets.dart';
import 'package:zig_project/utils/validations/validations.dart';

class SignIn extends StatefulWidget {
  static const String id = "/SignIn";
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;
  Validation _validationObject = Validation();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.12),
              child: Column(
                children: [
                  Image.asset(
                    AssetsManager.splaceLogo,
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    StringManager.signUpTittle,
                    style: TextStyle(color: ColorManager.primary, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    StringManager.signUpSubTittle,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Column(children: [
                    CommonWidgets.commonTextInputField(
                      showConfirmPassword: showConfirmPassword,
                      showPassword: showPassword,
                      isPassword: false,
                      label: StringManager.usernameLable,
                      obscureText: false,
                      validate: (value) =>
                          _validationObject.validateEmptyFields(
                              value, StringManager.validateEmptyUsername),
                      controller: _usernamecontroller,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CommonWidgets.commonTextInputField(
                        showPassword: showPassword,
                        showConfirmPassword: showConfirmPassword,
                        label: StringManager.emailLable,
                        obscureText: false,
                        isPassword: false,
                        validate: (value) =>
                            _validationObject.validateEmail(value),
                        controller: _emailcontroller),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonWidgets.commonTextInputField(
                        showConfirmPassword: showConfirmPassword,
                        showPassword: showPassword,
                        isPassword: true,
                        suffixAction: () {
                          setState(() {
                            if (showPassword) {
                              showPassword = false;
                            } else {
                              showPassword = true;
                            }
                          });
                        },
                        label: StringManager.passwordLable,
                        obscureText: !showPassword,
                        validate: (value) =>
                            _validationObject.validatePassword(value),
                        controller: _passwordcontroller),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonWidgets.commonTextInputField(
                        showConfirmPassword: showConfirmPassword,
                        showPassword: showPassword,
                        suffixAction: () {
                          setState(() {
                            if (showConfirmPassword) {
                              showConfirmPassword = false;
                            } else {
                              showConfirmPassword = true;
                            }
                          });
                        },
                        isConfirmPassword: true,
                        isLastField: true,
                        isPassword: true,
                        label: StringManager.confirmPasswordLable,
                        obscureText: !showConfirmPassword,
                        validate: (value) =>
                            _validationObject.validateConfirmPassword(
                                value, _passwordcontroller.text.trim()),
                        controller: _confirmpasswordcontroller),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonWidgets.commonMatrialButton(
                      buttonText: StringManager.signUpButtonText,
                      context: context,
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                CommonWidgets.loadingIndicator(),
                          );
                          final user = await _auth.createNewAccount(
                              email: _emailcontroller.text.trim(),
                              password: _confirmpasswordcontroller.text,
                              username: _usernamecontroller.text);
                          if (user == "success") {
                            Navigator.of(context)
                                .pushReplacementNamed(Dashboard.id);
                          } else {
                            //todo
                            Navigator.of(context).pop();
                            CommonWidgets.showSnakbar(context, user!);
                          }
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringManager.alreadyHaveAccountText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, LogIn.id);
                            },
                            child: Text(
                              StringManager.signupLoginButtonText,
                              style: TextStyle(color: ColorManager.primary),
                            ))
                      ],
                    )
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/reset_password/reset_password_screen.dart';
import 'package:zig_project/ui/screens/signup/signin_screen.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/widgets/widgets.dart';
import 'package:zig_project/utils/validations/validations.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  static const String id = "login";
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Auth _auth = Auth();
  bool isloading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  Validation _validationObject = Validation();
  bool showPassword = false;

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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  StringManager.loginSubTittle,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Column(children: [
                  CommonWidgets.commonTextInputField(
                      showConfirmPassword: false,
                      showPassword: false,
                      label: StringManager.emailLable,
                      obscureText: false,
                      isPassword: false,
                      validate: (value) =>
                          _validationObject.validateEmail(value),
                      controller: _emailcontroller),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonWidgets.commonTextInputField(
                      showConfirmPassword: false,
                      showPassword: false,
                      suffixAction: () {
                        setState(() {
                          if (showPassword) {
                            showPassword = false;
                          } else {
                            showPassword = true;
                          }
                        });
                      },
                      isLastField: true,
                      isPassword: true,
                      label: StringManager.passwordLable,
                      obscureText: !showPassword,
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return StringManager.validateEmptyPassword;
                        } else if (val.length <= 6) {
                          return StringManager.validatePasswordLength;
                        } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                          return StringManager.validatePasswordCharacter;
                        } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                          return StringManager.validatePasswordNumber;
                        }
                        return null;
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
                              Navigator.pushNamed(context, ResetPassword.id);
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
                  CommonWidgets.commonMatrialButton(
                    buttonText: StringManager.loginButtonText,
                    context: context,
                    onTap: () async {
                      _formkey.currentState!.activate();
                      if (_formkey.currentState!.validate()) {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) =>
                                CommonWidgets.loadingIndicator());

                        final user = await _auth.logInwithEmailandpassword(
                            _emailcontroller.text.trim(),
                            _passwordcontroller.text.trim());
                        if (user == "success") {
                          Navigator.pushReplacementNamed(context, Dashboard.id);
                        } else {
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(user.toString())));
                        }
                      }
                    },
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
                            Navigator.of(context)
                                .pushReplacementNamed(SignIn.id);
                          },
                          child: Text(
                            StringManager.loginCreateAccountButton,
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
    );
  }
}

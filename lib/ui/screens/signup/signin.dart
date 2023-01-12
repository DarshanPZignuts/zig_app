import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/login/login.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Auth _auth = Auth();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  RegExp regemail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool showPassword = false;
  bool showConfirmPassword = false;

  Widget _buildInput(
      {required String label,
      required bool isPassword,
      required TextEditingController controller,
      required bool obscureText,
      required String? validate(String? s),
      bool? isLastField,
      bool? isConfirmPassword}) {
    return Container(
        height: 80,
        width: 320,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validate,
            cursorColor: ColorManager.primary,
            cursorHeight: 20,
            style: TextStyle(color: ColorManager.primary),
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
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
                      icon: Icon(
                          isConfirmPassword == null
                              ? showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility
                              : showConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                          color: Colors.grey.shade500))
                  : null,
              label: Text(
                label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),
            ),
            textInputAction: isLastField == null
                ? TextInputAction.next
                : TextInputAction.done,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    StringManager.signUpTittle,
                    style: TextStyle(color: ColorManager.primary, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    StringManager.signUpSubTittle,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                    child: Column(children: [
                      _buildInput(
                          isPassword: false,
                          label: StringManager.usernameLable,
                          obscureText: false,
                          validate: (String? val) {
                            if (val!.isEmpty || val == null) {
                              return StringManager.validateEmptyUsername;
                            }
                          },
                          controller: _usernamecontroller),
                      const SizedBox(
                        height: 10,
                      ),
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
                        height: 15,
                      ),
                      _buildInput(
                          isPassword: true,
                          label: StringManager.passwordLable,
                          obscureText: !showPassword,
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
                          },
                          controller: _passwordcontroller),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildInput(
                          isConfirmPassword: true,
                          isLastField: true,
                          isPassword: true,
                          label: StringManager.confirmPasswordLable,
                          obscureText: !showConfirmPassword,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return StringManager.validateEmptyPassword;
                            } else if (!(val == _passwordcontroller.text)) {
                              return StringManager.validateConfirmPasswordMatch;
                            }
                          },
                          controller: _confirmpasswordcontroller),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            final user = await _auth.createNewAccount(
                                email: _emailcontroller.text.trim(),
                                password: _confirmpasswordcontroller.text,
                                username: _usernamecontroller.text);
                            if (user != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                            } else {
                              //todo
                              print("Failed to create new user!1");
                            }
                          } else {
                            print("Invalid");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorManager.primary),
                          fixedSize:
                              const MaterialStatePropertyAll(Size(200, 40)),
                        ),
                        child: const Text(
                          StringManager.signUpButtonText,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) => LogIn())));
                              },
                              child: Text(
                                StringManager.signupLoginButtonText,
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
      ),
    );
  }
}

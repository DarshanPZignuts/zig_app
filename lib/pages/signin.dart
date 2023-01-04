import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/authentication/auth.dart';
import 'package:zig_project/pages/dashboard.dart';

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

  Widget _buildInput(
      {required String label,
      required bool isPassword,
      required TextEditingController controller,
      required bool obscureText,
      required String? validate(String? s),
      required Function onTap}) {
    return Container(
        height: 60,
        width: 300,
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              validator: validate,
              cursorColor: Colors.amber,
              cursorHeight: 20,
              style: TextStyle(color: Colors.grey.shade600),
              controller: controller,
              obscureText: obscureText,
              onEditingComplete: onTap(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
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
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Container(
            child: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  height: height * 0.3,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 65),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 27),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Get started with new account",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: height * 0.7,
                  width: width,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 480),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.android,
                            color: Colors.amber,
                            size: 55,
                          ),
                          Text(
                            "©2022 Darshankumar vanol",
                            style: TextStyle(color: Colors.grey.shade400),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          Center(
            child: Form(
              key: _formkey,
              child: Container(
                height: 400,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(2, 2),
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInput(
                      isPassword: false,
                      label: "Username",
                      obscureText: false,
                      onTap: () {},
                      validate: (String? val) {
                        if (val!.isEmpty || val == null) {
                          return "* required";
                        }
                      },
                      controller: _usernamecontroller),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildInput(
                      label: "Email",
                      obscureText: false,
                      onTap: () {},
                      isPassword: false,
                      validate: (String? val) {
                        if (val!.isEmpty || val == null) {
                          return "* required";
                        } else if (!regemail.hasMatch(val)) {
                          return "Please enter correct email address";
                        }
                      },
                      controller: _emailcontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildInput(
                      isPassword: true,
                      label: "Password",
                      obscureText: !showPassword,
                      onTap: () {},
                      validate: (String? val) {
                        if (val!.isEmpty || val == null) {
                          return "* required";
                        } else if (val.length < 6) {
                          return "Length should be greater or equal to 6 character";
                        } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                          return "Please use characters";
                        } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                          return "Please use Numbers";
                        }
                      },
                      controller: _passwordcontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildInput(
                      isPassword: true,
                      label: "Confirm Password",
                      obscureText: !showPassword,
                      onTap: () {},
                      validate: (String? val) {
                        if (val!.isEmpty || val == null) {
                          return "* required";
                        } else if (!(val == _passwordcontroller.text)) {
                          return "Password not matched";
                        }
                      },
                      controller: _confirmpasswordcontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        final user = _auth.createNewAccount(
                            _emailcontroller.text, _passwordcontroller.text);
                        if (user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        } else {
                          print("Failed to create new user!1");
                        }
                      } else {
                        print("Invalid");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  )
                ]),
              ),
            ),
          )
        ])),
      ),
    );
  }
}

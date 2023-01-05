import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/authentication/auth.dart';
import 'package:zig_project/pages/dashboard.dart';
import 'package:zig_project/pages/resetpassword.dart';
import 'package:zig_project/pages/signin.dart';

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
              cursorColor: Colors.amber,
              cursorHeight: 20,
              style: TextStyle(color: Colors.amber),
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
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
                Hero(
                  tag: "icon",
                  child: Image.asset(
                    "lib/assets/itunes.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(height: height * 0.1),
                Text(
                  "Login",
                  style: TextStyle(color: Colors.amber, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome back,",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  child: Column(children: [
                    _buildInput(
                        label: "Email",
                        obscureText: false,
                        isPassword: false,
                        validate: (String? val) {
                          if (val!.isEmpty || val == null) {
                            return "Email should not be empty.";
                          } else if (!regemail.hasMatch(val)) {
                            return "Please enter correct email address";
                          }
                        },
                        controller: _emailcontroller),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildInput(
                        isLastField: true,
                        isPassword: true,
                        label: "Password",
                        obscureText: !showPassword,
                        validate: (String? val) {
                          if (val!.isEmpty || val == null) {
                            return "Password should not be empty";
                          } else if (val.length <= 6) {
                            return "Minimum 6 letter required";
                          } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                            return "Atleast one alphabet character required";
                          } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                            return "Atleast one number required";
                          }
                        },
                        controller: _passwordcontroller),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password?",
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
                              child: const Text(
                                "RESET",
                                style: TextStyle(color: Colors.amber),
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
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
                            MaterialStateProperty.all(Colors.amber),
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
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account?",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) => SignIn())));
                            },
                            child: const Text(
                              "Create Account",
                              style: TextStyle(color: Colors.amber),
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

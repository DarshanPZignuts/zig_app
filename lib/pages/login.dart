import 'package:flutter/material.dart';
import 'package:zig_project/pages/dashboard.dart';
import 'package:zig_project/pages/signin.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool showPassword = false;

  Widget _buildInput({
    required String label,
    required bool isPassword,
    required TextEditingController controller,
    required bool obscureText,
    required String? validate(String? s),
  }) {
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
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 27),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome back",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: height * 0.6419,
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
          Positioned(
            left: width * 0.1,
            top: height * 0.25,
            child: Form(
              key: _formkey,
              child: Container(
                height: height * 0.35,
                width: width * 0.8,
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
                  const SizedBox(
                    height: 10,
                  ),
                  _buildInput(
                      label: "Email",
                      obscureText: false,
                      isPassword: false,
                      validate: (String? val) {},
                      controller: _emailcontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildInput(
                      isPassword: true,
                      label: "Password",
                      obscureText: !showPassword,
                      validate: (String? val) {
                        if (val!.isEmpty || val == null) {
                          return "* required";
                        } else if (val.length < 6) {
                          return "Invalid password";
                        } else if (!RegExp(r"[a-zA-Z]").hasMatch(val)) {
                          return "Invalid password";
                        } else if (!RegExp(r"[0-9]").hasMatch(val)) {
                          return "Invalid password";
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
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "RESET",
                            style: TextStyle(color: Colors.amber),
                          )),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        //static email and password for testing purpose
                        if (_emailcontroller.text ==
                            "darshanvano009@gmail.com") {
                          if (_passwordcontroller.text == "test1234") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Dashboard())));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Incorrect Password!!")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Incorrect Email Address!!")));
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
                    ),
                    child: const Text(
                      "LOGIN",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                            Navigator.of(context).push(MaterialPageRoute(
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
            ),
          )
        ])),
      ),
    );
    ;
  }
}

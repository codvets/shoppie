import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/screens/buyer/clippaths/lower_clippath.dart';
import 'package:shop_app/screens/buyer/clippaths/upper_clippath.dart';

import 'package:shop_app/utils/routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: UpperClippath(),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(255, 169, 132, 1),
                  Color.fromRGBO(255, 121, 63, 1),
                ])),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Spacer(),
                      Text(
                        "Create Account",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                        controller: _nameController,
                        cursorColor: Color.fromRGBO(255, 121, 63, 1),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            hintText: "Enter your name",
                            labelStyle: TextStyle(color: Color(0xFF424242))),
                      ),
                    ),
                    const Text(
                      "Email Address",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (!emailRegex.hasMatch(val!)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        controller: _emailController,
                        cursorColor: Color.fromRGBO(255, 121, 63, 1),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            hintText: "Enter your email",
                            labelStyle: TextStyle(color: Color(0xFF424242))),
                      ),
                    ),
                    const Text(
                      "Password",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password too short!";
                          }
                          return null;
                        },
                        obscureText: isObsecure,
                        controller: _passwordController,
                        cursorColor: const Color.fromRGBO(255, 121, 63, 1),
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            hintText: "Enter your Password",
                            labelStyle:
                                const TextStyle(color: Color(0xFF424242)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObsecure = !isObsecure;
                                  });
                                },
                                icon: Icon(
                                  isObsecure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: isObsecure
                                      ? const Color(0xFF424242)
                                      : const Color.fromRGBO(255, 121, 63, 1),
                                ))),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 121, 63, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<AuthNotifier>(context, listen: false)
                              .register(context,
                                  name: _nameController.text.trim(),
                                  email: _emailController.text,
                                  password: _passwordController.text);
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: LowerClippath(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 169, 132, 60),
                      Color.fromRGBO(255, 121, 63, 60),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginScreen, (route) => false);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 121, 63, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/views/signup.dart';
import '../constants/navigation_routes.dart';
import '../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final bool emailValid = RegExp(
  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //     .hasMatch(this);

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPass;

  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPass = GlobalKey<FormState>();

  bool showPasswordpw = true;
  bool showPasswordcPW = true;

  Future<int> signup(email, password) async {
    // int _loginChecker;
    final uri = Uri.parse('http://192.168.10.119:3000/login');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
      // _loginChecker = 1;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      // _loginChecker = 0;
      print(response.body);
    }

    return response.statusCode;
  }

  // Setting initState function to control both
  // late variables: _email, _password
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPass = TextEditingController();
    super.initState();
  }

  // Disposing both emails and passwords to avoid leakage

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  void clearText() {
    _email.clear();
    _password.clear();
    _confirmPass.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
        builder: (context, snapshot) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/SignupBG.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: ClipPath(
                            clipper: TopClipPath(),
                            child: Container(
                              color: const Color.fromARGB(255, 84, 122, 70),
                              height: 160,
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: TopClipPath(),
                          child: Container(
                            color: const Color.fromARGB(150, 78, 112, 67),
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/logo 1.png',
                        ),
                        const Text(
                          'Construction? We got you!',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    const Text(
                      "Create a new account",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Form(
                            key: _formKeyEmail,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              controller: _email,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Form(
                            key: _formKeyPassword,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              obscureText: showPasswordpw,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPasswordpw
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  color: Colors.black45,
                                  onPressed: () => setState(
                                      () => showPasswordpw = !showPasswordpw),
                                ),
                              ),
                              controller: _password,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        // Confirm password placeholder
                        const SizedBox(
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Confirm Password",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Form(
                            key: _formKeyConfirmPass,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              obscureText: showPasswordcPW,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPasswordcPW
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  color: Colors.black45,
                                  onPressed: () => setState(
                                      () => showPasswordcPW = !showPasswordcPW),
                                ),
                              ),
                              controller: _confirmPass,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _password.text) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 50),
                              backgroundColor:
                                  const Color.fromARGB(149, 89, 148, 67),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                          onPressed: () {
                            final email = _email.text;
                            final password = _password.text;

                            // Check whether inserted text for each form is valid.
                            if (_formKeyEmail.currentState!.validate()) {
                              if (_formKeyPassword.currentState!.validate()) {
                                if (_formKeyConfirmPass.currentState!
                                    .validate()) {
                                  if (kDebugMode) {
                                    print("Email: $email");
                                    print("Password: $password");

                                    clearText();
                                    navigateToVerifyPage(context);
                                  }
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateToLoginPage(context);
                                },
                                child: const Text(
                                  "    Login",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 21, 253, 141)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: ClipPath(
                              clipper: BottomClipPath(),
                              child: Container(
                                color: const Color.fromARGB(255, 84, 122, 70),
                                height: 160,
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: TranspBottomClipPath(),
                            child: Container(
                              color: const Color.fromARGB(150, 78, 112, 67),
                              height: 160,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> _selectDate(BuildContext context) async {
  final now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1950),
      lastDate: DateTime(2101));
  if (picked != null && picked != date) {
    //print('hello $picked');
    date = picked;
  }
}

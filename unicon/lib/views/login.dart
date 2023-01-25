import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/navigation_routes.dart';
import '../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  var statusCode;
  bool showPassword = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void clearText() {
    _email.clear();
    _password.clear();
  }

  Future<int> login(email, password) async {
    // int _loginChecker;
    final uri = Uri.parse('http://192.168.75.119:3000/login');
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
      print(jsonDecode(response.body)["err"]);
    }

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginBG.png"),
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
            ),
            const Text(
              "Login to get started!",
              style: TextStyle(color: Colors.grey),
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
                      obscureText: showPassword,
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
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.black45,
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
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
                SizedBox(
                  width: 300,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        navigateToResetPWPage(context);
                      },
                      child: const Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color.fromARGB(255, 21, 253, 141)),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(149, 89, 148, 67),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;

                    if (_formKeyEmail.currentState!.validate()) {
                      if (_formKeyPassword.currentState!.validate()) {
                        if (kDebugMode) {
                          print("Email: $email");
                          print("Password: $password");
                          // print(email.runtimeType);

                          // login system
                          statusCode = await login(email, password);
                          print(statusCode);
                          if (statusCode == 200) {
                            clearText();
                            navigateToHome(context);
                          } else {
                            clearText();
                            // Error message (for users)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 90,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFC72C41),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "OH NO!",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "You've entered a wrong login information. Please try to login again.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          navigateToSignUpPage(context);
                        },
                        child: const Text(
                          "    Create Now",
                          style: TextStyle(
                              color: Color.fromARGB(255, 21, 253, 141)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

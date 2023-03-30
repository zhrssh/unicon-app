// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/navigation_routes.dart';
import '../constants/top_bottom_clippings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late BuildContext _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  // For account log in
  late final TextEditingController _email;
  late final TextEditingController _password;

  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  // For refresh token
  // AndroidOptions getAndroidOptions() =>
  //     const AndroidOptions(encryptedSharedPreferences: true);
  // late final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  // For http
  late http.Response response;

  // For display password
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

  Future<void> showLoginErrorSnackBar(String message) async {
    ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OH NO!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ));
  }

  // Logins to the server
  Future<http.Response> login(email, password) async {
    // int _loginChecker;
    final uri = Uri.parse('http://${dotenv.env["AUTH_URL"]}/login');
    late final http.Response response;

    try {
      response = await http.post(
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
    } catch (err) {
      response = http.Response(err.toString(), 500);
    }

    return response;
  }

  // Checks if the resource server is active
  Future<http.Response> checkRscServer(accessToken) async {
    final uri = Uri.parse("http://${dotenv.env["RSC_URL"]}/api");
    late final http.Response response;

    try {
      response = await http.get(uri,
          headers: <String, String>{"Authorization": "Bearer $accessToken"});
    } catch (err) {
      response = http.Response(err.toString(), 500);
    }

    return response;
  }

  Future<void> showLoaderDialog() async {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Logging in...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                      height: 120,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: TopClipPath(),
                  child: Container(
                    color: const Color.fromARGB(150, 78, 112, 67),
                    height: 70,
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
                        setContext(context);
                        navigateToResetPWPage(_context);
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
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    setContext(context);
                    showLoaderDialog();
                    final email = _email.text;
                    final password = _password.text;

                    if (_formKeyEmail.currentState!.validate()) {
                      if (_formKeyPassword.currentState!.validate()) {
                        response = await login(email, password);

                        // Prints user input and response status code
                        if (kDebugMode) {
                          print("Email: $email");
                          print("Password: $password");
                          print("Login Status: ${response.statusCode}");
                        }

                        // Removes the "Logging in" dialog
                        Navigator.pop(_context);

                        switch (response.statusCode) {
                          case 200: // If the login succeeds
                            clearText();

                            // Will use the received access token to communicate with the server
                            final body = jsonDecode(response.body);
                            final accessToken = body["accessToken"];

                            // Store refreshToken somewhere in the device
                            // final refreshToken = body["refreshToken"];
                            // await storage.write(
                            //   key: 'jwt',
                            //   value: refreshToken,
                            // );

                            // Checks if the resource server is active
                            response = await checkRscServer(accessToken);
                            if (kDebugMode) {
                              print(
                                  "Rsc Server Status: ${response.statusCode}");
                              print(response.body);
                            }

                            if (response.statusCode == 200) {
                              // TODO: vvvvvv TEST IF WORKING vvvvvvv
                              // Check if client or provider
                              final doc = json.decode(response.body);
                              final accountType = doc["accountType"];

                              switch (accountType) {
                                // Proceed to client home
                                case "client":
                                  navigateToClientHome(context, accessToken);
                                  break;
                                // Proceed to provider home
                                case "provider":
                                  // navigateToProviderHome(context, accessToken);
                                  break;
                                default:
                                  showLoginErrorSnackBar(
                                      "We've encountered an unexpected error in the server. Please try again later.");
                                  break;
                              }
                            } else {
                              showLoginErrorSnackBar(
                                  "We've encountered an unexpected error in the server. Please try again later.");
                            }
                            break;

                          case 401:
                            showLoginErrorSnackBar(
                                "You've entered the wrong login information. Please try again.");
                            break;

                          case 404:
                            showLoginErrorSnackBar(
                                "Email does not exists. Please try again later.");
                            break;

                          default:
                            showLoginErrorSnackBar(
                                "We've encountered an unexpected error. Please try again later.");
                            break;
                        }
                      }
                    }
                  },
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
                        onPressed: () => navigateToRegTypePage(context),
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

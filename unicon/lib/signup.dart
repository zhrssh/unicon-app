import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'login.dart';
import 'verify.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Registration Page',
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

DateTime date = DateTime.now();
TextEditingController dateset = TextEditingController();

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/SignupBG.png"),
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
                      'images/logo 1.png',
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "First Name",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Last Name",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Birthdate",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: 'Birthdate',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                controller: dateset,
                                onTap: () async {
                                  // Below line stops keyboard from appearing
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // Show Date Picker Here
                                  await _selectDate(context);
                                  dateset.text =
                                      DateFormat('yyyy/MM/dd').format(date);
                                  //setState(() {});
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Mobile Number",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    ),
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
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.visibility_off),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
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
                        navigateToVerifyPage(context);
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
      ),
    );
  }
}

class TopClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TranspBottomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.35);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Future navigateToLoginPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

Future navigateToVerifyPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const VerifyPage()));
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
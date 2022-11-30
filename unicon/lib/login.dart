import 'package:flutter/material.dart';
import 'signup.dart';
import 'resetpw.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/loginBG.png"),
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
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'juandelacruz@gmail.com',
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                        style: TextStyle(
                            color: Color.fromARGB(255, 112, 221, 175)),
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
                      )),
                  onPressed: () {},
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

Future navigateToSignUpPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SignUpPage()));
}

Future navigateToResetPWPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ResetPWPage()));
}

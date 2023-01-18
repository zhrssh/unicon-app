import 'package:flutter/material.dart';
import '../constants/navigation_routes.dart';
import '../constants/top_bottom_clippings.dart';
import '../constants/textfields.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
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
                const SizedBox(
                  width: 300,
                  child: Email(displayedText: "JuanDelaCruz@gmail.com"),
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
                const SizedBox(
                  width: 300,
                  child: Password(),
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
                      )),
                  onPressed: () {
                    navigateToHomePage(context);
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

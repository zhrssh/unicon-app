import 'package:flutter/material.dart';
import '../constants/top_bottom_clippings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reset Password Page',
      debugShowCheckedModeBanner: false,
      home: ResetPWPage(),
    );
  }
}

class ResetPWPage extends StatelessWidget {
  const ResetPWPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ResetPWBG.png"),
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
                      height: 120,
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              SizedBox(
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    ),
                    Text(
                      "Please enter your email address to request a password reset.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              ),
              SizedBox(
                width: 320,
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.mail_outline_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'abc@email.com',
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
              Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(280, 60),
                          backgroundColor:
                              const Color.fromARGB(172, 178, 224, 161),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_circle_right_rounded),
                      label: const Text(
                        'SEND',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import '../constants/top_bottom_clippings.dart';
import 'signup.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Verification Page',
      debugShowCheckedModeBanner: false,
      home: VerifyPage(),
    );
  }
}

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/VerifyBG.png"),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Verification",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  ),
                  Text(
                    "We've send you the verification code on",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "+1 2620 0323 7631",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              PinCodeFields(
                length: 4,
                fieldBorderStyle: FieldBorderStyle.square,
                responsive: true,
                fieldHeight: 60.0,
                fieldWidth: 20.0,
                borderWidth: 1.0,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                activeBorderColor: Colors.black,
                activeBackgroundColor: const Color.fromARGB(172, 178, 224, 161),
                borderRadius: BorderRadius.circular(10.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                fieldBackgroundColor: Colors.white,
                borderColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (output) {},
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              ),
              Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 50),
                          backgroundColor:
                              const Color.fromARGB(172, 178, 224, 161),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        'CONTINUE',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  ),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Resend code in ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "0:20",
                          style: TextStyle(
                              color: Color.fromARGB(255, 21, 253, 141)),
                        ),
                      ],
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

Future navigateToLoginPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SignUpPage()));
}

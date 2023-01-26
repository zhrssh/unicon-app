import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import '../constants/top_bottom_clippings.dart';
import '../constants/navigation_routes.dart';
import 'package:http/http.dart' as http;

class VerifyPage extends StatefulWidget {
  final String uuid;
  const VerifyPage({super.key, required this.uuid});

  @override
  State<VerifyPage> createState() => _VerifyPageState(uuid);
}

class _VerifyPageState extends State<VerifyPage> {
  final String _uuid;
  _VerifyPageState(this._uuid);

  late final TextEditingController _verification;
  late final _formKeyVerification = GlobalKey<FormState>();
  var statusCode;

  @override
  void initState() {
    _verification = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _verification.dispose();
    super.dispose();
  }

  void clearText() {
    _verification.clear();
  }

  Future<int> verification(uuid, verificationCode) async {
    // int _loginChecker;
    String url =
        "http://192.168.75.119:3000/register/verify/$uuid/$verificationCode";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
    );
    // print(url);
    return response.statusCode;
  }

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
                    "the email you registered.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              SizedBox(
                width: 300,
                child: Form(
                  key: _formKeyVerification,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "6-Pin Verification",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    controller: _verification,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter verification code';
                      }
                      if (value.length > 6) {
                        return 'Verification code exceeds character limit';
                      }
                      if (value.length < 6) {
                        return 'Verification code is insufficient';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              /*PinCodeFields(
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
              ),*/
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
                      onPressed: () async {
                        final verificationCode = _verification.text;

                        if (_formKeyVerification.currentState!.validate()) {
                          if (kDebugMode) {
                            print("Verification code: $verificationCode");
                          }
                          statusCode =
                              await verification(_uuid, verificationCode);
                          if (statusCode == 200) {
                            navigateToLoginPage(context);
                            clearText();
                            // dispose();
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
                          // dispose();
                        }
                        // navigateToLoginPage(context);
                      },
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
                  // Text(
                  //   _uuid,
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
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

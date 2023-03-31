// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/top_bottom_clippings.dart';
import '../constants/navigation_routes.dart';

class VerifyPage extends StatefulWidget {
  final String uuid;
  final String email;
  final Map<String, dynamic> data;
  const VerifyPage(
      {super.key, required this.uuid, required this.email, required this.data});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late final TextEditingController _verification;
  late final _formKeyVerification = GlobalKey<FormState>();
  late final int? statusCode;

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

  Future<http.Response> verification(uuid, verificationCode) async {
    // int _loginChecker;
    String url =
        "https://${dotenv.env["AUTH_URL"]}/register/verify/$uuid/$verificationCode";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
    );

    if (kDebugMode) print(response.body);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      onPressed: () {
                        final verificationCode = _verification.text;

                        if (_formKeyVerification.currentState!.validate()) {
                          if (kDebugMode) {
                            print("Verification code: $verificationCode");
                          }

                          verification(widget.uuid, verificationCode)
                              .then((response) {
                            if (response.statusCode == 200) {
                              var jsonBody = jsonDecode(response.body);
                              widget.data.addAll(
                                  {"accessToken": jsonBody["accessToken"]});

                              if (widget.data["accountType"] == "client") {
                                navigateToClientRegisterInfoPage(
                                    context, widget.email, widget.data);
                              }

                              if (widget.data["accountType"] == "provider") {
                                navigateToProviderRegType(
                                    context, widget.email, widget.data);
                              }

                              clearText();
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
                                          "You've entered a wrong verification code. Please try again.",
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
                          });
                        }
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
                      children: [
                        GestureDetector(
                          child: const Text(
                            "Tap here",
                            style: TextStyle(
                              color: Color.fromARGB(255, 21, 253, 141),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () async {
                            final http.Response response = await http.post(
                              Uri.parse(
                                  "https://${dotenv.env["AUTH_URL"]}/register/verify/resend"),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(
                                <String, String>{
                                  'email': widget.email,
                                },
                              ),
                            );

                            if (kDebugMode) {
                              print(response.body);
                            }

                            if (response.statusCode != 200) {
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
                                          "There's some error sending the code. Please try again.",
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
                          },
                        ),
                        const Text(
                          " to resend code.",
                          style: TextStyle(color: Colors.white),
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

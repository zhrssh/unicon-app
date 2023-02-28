import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/navigation_routes.dart';
import '../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: RegTypePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class RegTypePage extends StatefulWidget {
  const RegTypePage({super.key});

  @override
  State<RegTypePage> createState() => _RegTypePageState();
}

class _RegTypePageState extends State<RegTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginBG.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
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
            "Select your account type",
            style: TextStyle(color: Colors.grey),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
          Column(
            children: [
              InkWell(
                onTap: (() {
                  // Sends account type to next page
                  final Map<String, dynamic> accountType = {
                    "accountType": "client"
                  };
                  navigateToSignUpPage(context, accountType);
                }),
                child: Container(
                  height: 112,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      ),
                      Image.asset(
                        'assets/images/FindServices.png',
                        width: 97,
                        height: 93,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10)),
                          Text(
                            'Find Services',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Construction needs?',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text('We got you!', style: TextStyle(fontSize: 12))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
          InkWell(
            onTap: () {
              // Sends account type to next page
              final Map<String, dynamic> accountType = {
                "accountType": "provider"
              };
              navigateToSignUpPage(context, accountType);
            },
            child: Container(
              height: 112,
              width: 340,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  ),
                  Image.asset(
                    'assets/images/OfferServices.png',
                    width: 124,
                    height: 99,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10)),
                      Text(
                        'Offer Services',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Offer your services and',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text('become a partner.', style: TextStyle(fontSize: 12))
                    ],
                  )
                ],
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 0)),
          InkWell(
            onTap: () {
              navigateToLoginPage(context);
            },
            child: const Text(
              "Already have an account?",
              style: TextStyle(color: Color.fromARGB(255, 56, 218, 72)),
            ),
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
        ]),
      ),
    );
  }
}

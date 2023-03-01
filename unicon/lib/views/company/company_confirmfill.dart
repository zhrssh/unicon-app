import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/views/company/company_confirmfill2.dart';
import '../../constants/navigation_routes.dart';
import '../../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: CompanyConfirmFill(),
    debugShowCheckedModeBanner: false,
  ));
}

class CompanyConfirmFill extends StatefulWidget {
  const CompanyConfirmFill({super.key});

  @override
  State<CompanyConfirmFill> createState() => _CompanyConfirmFillState();
}

class _CompanyConfirmFillState extends State<CompanyConfirmFill> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<Object>(builder: (context, snapshot) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/SignupBG.png"),
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
                const Text(
                  "Confirm Identification",
                  style: TextStyle(color: Colors.grey),
                ),
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "2 Valid Government ID",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " (Driver’s License,",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 0)),
                          const Text(
                            "National ID, PhilHealth, Postal ID, NBI ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 0)),
                          const Text(
                            "Clearance)",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                    Column(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.file_download_outlined,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Attach File",
                            style: TextStyle(color: Colors.grey),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(300, 45),
                              alignment: Alignment.centerLeft),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0)),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.file_download_outlined,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Attach File",
                            style: TextStyle(color: Colors.grey),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(300, 45),
                              alignment: Alignment.centerLeft),
                        )
                      ],
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Photo Verification",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " (Copy the man's hand",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 0)),
                          const Text(
                            "position in the picture below)",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/left-handed-man-verification.png',
                                width: 131,
                                height: 113,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  fixedSize: const Size(135, 113),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {},
                                child: const Icon(
                                  Icons.file_download_outlined,
                                  size: 60,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 0)),
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: const [
                          Text(
                            "Note: The verification of Identity may take up to 24 hours, for further questions and inquiries, you may use the helpdesk.",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 11.5),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 40),
                        backgroundColor: const Color.fromARGB(255, 104, 147, 89),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CompanyConfirmFill2()));
                      }, 
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18),
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
              ]),
            ),
          );
        }));
  }
}

import 'package:flutter/material.dart';
import '../../../constants/navigation_routes.dart';
import '../../../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: CompanyConfirmFill2(),
    debugShowCheckedModeBanner: false,
  ));
}

class CompanyConfirmFill2 extends StatefulWidget {
  const CompanyConfirmFill2({super.key});

  @override
  State<CompanyConfirmFill2> createState() => _CompanyConfirmFill2State();
}

class _CompanyConfirmFill2State extends State<CompanyConfirmFill2> {
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
                  "Confirm Company Identity",
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
                                "Valid Company Permits",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " (PCAB License, DTI",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 0)),
                          const Text(
                            "Permit, BIR Clearance)",
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
                            "Attach File (PCAB License)",
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
                            "Attach File (DTI Permit)",
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
                            "Attach File (BIR Clearance)",
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
                            EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
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
                            EdgeInsets.symmetric(vertical: 50, horizontal: 0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 40),
                        backgroundColor:
                            const Color.fromARGB(255, 104, 147, 89),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () => navigateToLoginPage(
                          context), //navigate to provider/company homepage
                      child: const Text(
                        'Submit',
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

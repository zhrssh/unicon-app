import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 1,
      ),
      body: SizedBox(
        // child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            CircleAvatar(
              radius: 80,
              child: Image.asset('assets/images/avatar1.jpg'),
              // backgroundImage: AssetImage("assets/images/avatar1.jpg"),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 1),
            ),
            const Text(
              "Andrew Tate",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 30,
              ),
            ),
            SizedBox(
              // width: 300,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "About Me",
                        style: TextStyle(
                          color: Color.fromARGB(255, 34, 27, 61),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 84, 122, 70),
                              style: BorderStyle.solid),
                        ),
                        child: const Text("Edit Profile",
                            style: TextStyle(
                              color: Color.fromARGB(255, 84, 122, 70),
                            )),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Businessman | Entrepreneur | Philantropist",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              // height: ,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(
              // width: 300,

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: const <Widget>[
                      Text(
                        "Contact Information",
                        style: TextStyle(
                          color: Color.fromARGB(255, 34, 27, 61),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Contact Number",
                            textAlign: TextAlign.left,
                          ),
                          Text("Email Address", textAlign: TextAlign.left),
                          Text("Country", textAlign: TextAlign.left),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("+63 999 1234 567"),
                          Text("andrewtate@gmail.com"),
                          Text("Philippines"),
                        ],
                      )

                      //           Text(
                      //             "Contact Number",
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //           Text(
                      //             "+63 999 9999 999",
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const Padding(
                      //         padding: EdgeInsets.symmetric(
                      //           vertical: 5,
                      //         ),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         mainAxisSize: MainAxisSize.max,
                      //         children: const <Widget>[
                      //           Text(
                      //             "Email Address",
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //           Text(
                      //             "andrewtategigachad@gmail.com",
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                    ],
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 20),
            // ),
            // SizedBox(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Center(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           mainAxisSize: MainAxisSize.max,
            //           children: [
            //             const Text(
            //               "Interests",
            //               style: TextStyle(
            //                 color: Color.fromARGB(255, 34, 27, 61),
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w800,
            //               ),
            //             ),
            //             OutlinedButton(
            //               onPressed: () {},
            //               style: OutlinedButton.styleFrom(
            //                 side: const BorderSide(
            //                     color: Color.fromARGB(255, 84, 122, 70),
            //                     style: BorderStyle.solid),
            //               ),
            //               child: const Text("Edit Profile",
            //                   style: TextStyle(
            //                     color: Color.fromARGB(255, 84, 122, 70),
            //                   )),
            //             ),
            //           ],
            //         ),
            //       ),
            //       const Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           "Businessman | Entrepreneur | Philantropist",
            //           style: TextStyle(
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

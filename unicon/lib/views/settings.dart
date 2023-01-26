import 'package:flutter/material.dart';
import 'signup.dart';
import 'resetpw.dart';
import 'settingsPages/notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Settings Page',
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        toolbarHeight: 75.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: TopClipPath(),
                      child: Container(
                        color: const Color.fromARGB(255, 84, 122, 70),
                        height: 180,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      ),
                      Image.asset(
                        'assets/images/logo 1.png',
                      ),
                      const Text(
                        'Construction? We got you!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 225,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Expanded(
                        child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.newspaper),
                          title: const Text("Edit Profile"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications_none_rounded),
                          title: const Text("Notifications"),
                          trailing: const Text("ON"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationPage()));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.password_rounded),
                          title: const Text("Change Password"),
                          onTap: () {},
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 175,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Expanded(
                        child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.support_agent),
                          title: const Text("Help & Support"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.message),
                          title: const Text("Contact Us"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.lock_outline),
                          title: const Text("Privacy Policy"),
                          onTap: () {},
                        )
                      ],
                    )),
                  ),
                ],
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
    path.lineTo(0.0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0.0);
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

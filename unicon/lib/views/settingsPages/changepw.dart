import 'package:flutter/material.dart';

import '../../constants/top_bottom_clippings.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Change Password Page',
      debugShowCheckedModeBanner: false,
    );
  }
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  bool showOldPassword = true;
  bool showNewPassword = true;
  bool showConfirmNewPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        toolbarHeight: 75.0,
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: TopClipPathForChangePW(),
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
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        ),
                        const Text(
                          'Change Password',
                          style: TextStyle(color: Colors.white60, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              ),
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: showOldPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(),
                        hintText: "Old Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showOldPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.black45,
                          onPressed: () => setState(
                              () => showOldPassword = !showOldPassword),
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: showNewPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(),
                        hintText: "New Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showNewPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.black45,
                          onPressed: () => setState(
                              () => showNewPassword = !showNewPassword),
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: showConfirmNewPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(),
                        hintText: "Confirm New Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showConfirmNewPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.black45,
                          onPressed: () => setState(() =>
                              showConfirmNewPassword = !showConfirmNewPassword),
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 5)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(230, 50),
                        backgroundColor: const Color.fromARGB(149, 89, 148, 67),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
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
            ],
          ),
        ),
      ]),
    );
  }
}

class TopClipPathForChangePW extends CustomClipper<Path> {
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

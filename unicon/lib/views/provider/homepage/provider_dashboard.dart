import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/views/provider/homepage/provider_projects.dart';

import '../provider_navigation_drawer.dart';

// import 'package:untitled/views/calendar.dart';
// import 'package:untitled/views/location.dart';
// import 'package:untitled/views/profile.dart';

class ProviderDashboard extends StatefulWidget {
  final String token;
  const ProviderDashboard({super.key, required this.token});

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  Future<http.Response> _getUserInfo() async {
    final uri =
        Uri.parse('http://${dotenv.env["RSC_URL"]}/api/provider/profile');
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder(
          future: _getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      height: 200,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 200,
                  ),
                  Text('${snapshot.error}'),
                ],
              ));
            } else {
              final response = snapshot.data as http.Response;
              final user = json.decode(response.body);

              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(
                          right: 15 + MediaQuery.of(context).padding.right),
                      icon: SizedBox(
                        height: 30,
                        child: Image.asset('assets/icons/notification.png'),
                      ),
                      onPressed: () {},
                    )
                  ],
                  title: Column(
                    children: <Widget>[
                      Text("Hi, ${user["name"]["firstName"]}!"),
                    ],
                  ),
                  centerTitle: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: const Color.fromARGB(255, 84, 122, 70),
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        cursorColor: Colors.white,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white54,
                          ),
                          hintText: "Search for jobs",
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.grey[50],
                drawer: CustomNavigationDrawer(
                  token: widget.token,
                  email: user["email"],
                  name:
                      "${user["name"]["firstName"]} ${user["name"]["lastName"]}",
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Jobs Today (Near you)",
                                style: TextStyle(
                                  color: Color.fromARGB(200, 18, 13, 38),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                      (states) => const Color.fromARGB(
                                          100, 84, 122, 70),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      const Text(
                                        "See All",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Image.asset(
                                          "assets/icons/arrow_right.png"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 500,
                          child: ProviderProjectList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

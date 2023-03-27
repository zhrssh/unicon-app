import 'dart:convert';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:untitled/constants/navigation_routes.dart';
import '../../../actions/models.dart';

class ClientProfilePage extends StatefulWidget {
  final String token;
  const ClientProfilePage({super.key, required this.token});

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  List<Color> chipColors = const [
    Color.fromARGB(255, 107, 122, 237),
    Color.fromARGB(255, 184, 16, 4),
    Color.fromARGB(255, 255, 141, 93),
    Color.fromARGB(255, 41, 214, 151),
    Color.fromARGB(255, 15, 64, 138),
    Color.fromARGB(255, 141, 33, 114),
  ];

  final List<ChipModel> _chipList = []; // storage for all tags entered by user
  late final TextEditingController
      _chipText; // text editing controller for tags

  final String _profileImage =
      "assets/images/andrew tate.png"; // importing image

  // TODO: Check if user profile is working
  // For user profile
  late final dynamic user;
  late final dynamic imageData;

  @override
  void initState() {
    // Get info from server
    _getUserInfo();
    _chipText = TextEditingController();
    super.initState();
  }

  void _getUserInfo() async {
    final uri = Uri.parse('http://${dotenv.env["RSC_URL"]}/api/client/profile');
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      user = json.decode(response.body);
      imageData = response.bodyBytes;
    }
  }

  // removing tags/chips
  void _deleteChip(String id) {
    setState(
      () {
        _chipList.removeWhere((element) => element.id == id);
      },
    );
  }

  // function to return random color
  Color randomColor() {
    Random random = Random();
    int index = random.nextInt(chipColors.length);
    return chipColors[index];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 100,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: const BackButton(
      //     color: Colors.black,
      //   ),
      //   leadingWidth: 30,
      //   title: const Text("Profile"),
      //   titleTextStyle: const TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 20,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * .05,
            ),
            SizedBox(
              child: Row(
                children: [
                  TextButton(
                    onPressed: (() {
                      navigateToClientHome(context, widget.token);
                      // Navigator.pop(context);
                    }),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: SizedBox(
                // child: Padding(
                // padding: EdgeInsets.symmetric(vertical: height * .01),
                child: Container(
                  // color: Colors.redAccent,
                  padding: const EdgeInsets.all(8.0),
                  // height: height * .20,
                  width: width * .8,
                  child: Column(
                    children: <Widget>[
                      Material(
                        // elevation: 5,
                        borderRadius: BorderRadius.circular(80),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(_profileImage),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        user['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // ),
            SizedBox(
              // height: height * .25,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * .01,
                ),
                child: SizedBox(
                  // color: Colors.redAccent,
                  width: width * .8,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const Text(
                            "About Me",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 84, 122, 70),
                                  style: BorderStyle.solid),
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Color.fromARGB(255, 84, 122, 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Businessman | Etrepreneur | Philantropist",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Contact Information",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: height * .03,
                                ),
                                const Text(
                                  "Contact Number",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "Email Address",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "Location",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: height * .03,
                                ),
                                const Text(
                                  "+63 999 9999 999",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "andrewtate@gmail.com",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "Quezon City, Philippines",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const Text(
                            "Interests",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: const Text("Input Tags"),
                                    content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            TextField(
                                              controller: _chipText,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 84, 122, 70),
                                              ),
                                              onPressed: (() {
                                                setState(
                                                  () {
                                                    // adding each chip/tag inputted by the user
                                                    // in the text field to _chipList
                                                    _chipList.add(
                                                      ChipModel(
                                                          id: DateTime.now()
                                                              .toString(),
                                                          name: _chipText.text),
                                                    );
                                                    _chipText.text =
                                                        ''; // setting the input text to empty string
                                                    Navigator.of(context)
                                                        .pop(); // closing dialog
                                                  },
                                                );
                                              }),
                                              child: const Text("Add tag"),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 84, 122, 70),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: const Text(
                              "Change",
                              style: TextStyle(
                                color: Color.fromARGB(255, 84, 122, 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 5,
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: _chipList
                              .map((chip) => Chip(
                                    key: ValueKey(chip.id),
                                    label: Text(
                                      chip.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: randomColor(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    deleteIconColor: Colors.white,
                                    onDeleted: (() => _deleteChip(chip.id)),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

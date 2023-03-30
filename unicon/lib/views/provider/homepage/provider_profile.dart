import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../actions/models.dart';
import '../provider_navigation_routes.dart';

class ProviderProfilePage extends StatefulWidget {
  final String token;
  const ProviderProfilePage({super.key, required this.token});

  @override
  State<ProviderProfilePage> createState() => _ProviderProfilePageState();
}

class _ProviderProfilePageState extends State<ProviderProfilePage> {
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
      "assets/images/profile-placeholder.png"; // importing image

  @override
  void initState() {
    _chipText = TextEditingController();
    super.initState();
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              return Column(
                children: [
                  SizedBox(
                    height: height * .075,
                  ),
                  SizedBox(
                    child: Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            navigateToProviderHome(context, widget.token);
                            // Navigator.pop(context);
                          },
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
                        ),
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
                            SizedBox(
                              height: 60,
                              child: Text(
                                "${user['name']['firstName']} ${user['name']['lastName']}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Text(
                            //   "${user['name']['lastName']}",
                            //   style: const TextStyle(
                            //     fontSize: 24,
                            //     fontWeight: FontWeight.w800,
                            //   ),
                            // ),
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
                                "Businessman | Entrepreneur | Philantropist",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Text(
                                        user['contactNumber'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        user['email'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        user['location'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  TextField(
                                                    controller: _chipText,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
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
                                                                id: DateTime
                                                                        .now()
                                                                    .toString(),
                                                                name: _chipText
                                                                    .text),
                                                          );
                                                          _chipText.text =
                                                              ''; // setting the input text to empty string
                                                          Navigator.of(context)
                                                              .pop(); // closing dialog
                                                        },
                                                      );
                                                    }),
                                                    child:
                                                        const Text("Add tag"),
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
                                          onDeleted: (() =>
                                              _deleteChip(chip.id)),
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
              );
            }
          },
        ),
      ),
    );
  }
}

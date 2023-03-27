// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/navigation_routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants/top_bottom_clippings.dart';

void main() {
  runApp(const MaterialApp(
    home: ClientRegisterInfoPage(data: <String, dynamic>{"test": "test"}),
    debugShowCheckedModeBanner: false,
  ));
}

class ClientRegisterInfoPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const ClientRegisterInfoPage({super.key, required this.data});

  @override
  State<ClientRegisterInfoPage> createState() => _ClientRegisterInfoPageState();
}

class _ClientRegisterInfoPageState extends State<ClientRegisterInfoPage> {
  bool termsAndConditions = false;

  // Controllers
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _contactNumberController.dispose();
    _locationController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    Map<String, dynamic> userInfo = {
      "name": {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "middleName": _middleNameController.text
      },
      "birthDate": _birthDateController.text,
      "contactNumber": _contactNumberController.text,
      "location": _locationController.text,
      "company": _companyController.text
    };

    final http.Response response = await register(
        widget.data["accountType"], widget.data["accessToken"], userInfo);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      return navigateToLoginPage(context);
    } else {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "OH NO!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "There's an error in your registration. Please try again.",
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

      return;
    }
  }

  Future<http.Response> register(
      String accountType, String accessToken, Map<String, dynamic> data) async {
    final uri =
        Uri.parse("http://${dotenv.env["RSC_URL"]}/api/$accountType/register");
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(data),
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    height: 120,
                  ),
                ),
              ),
              ClipPath(
                clipper: TopClipPath(),
                child: Container(
                  color: const Color.fromARGB(150, 78, 112, 67),
                  height: 70,
                ),
              ),
            ],
          ),
          const Text(
            "Please complete your registration.",
            style: TextStyle(color: Colors.grey),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        width: 145,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "First Name",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 145,
                        child: Form(
                          child: TextFormField(
                            controller: _firstNameController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "First Name",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                  Column(
                    children: [
                      const SizedBox(
                        width: 145,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Middle Name",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 145,
                        child: Form(
                          child: TextFormField(
                            controller: _middleNameController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Middle Name",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
              const SizedBox(
                width: 300,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Last Name",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Form(
                  child: TextFormField(
                    controller: _lastNameController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Last Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        width: 145,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Birthdate",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 145,
                        child: Form(
                          child: TextFormField(
                            controller: _birthDateController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "yyyy-mm-dd",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your birthdate';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());

                              if (pickeddate != null) {
                                setState(() {
                                  _birthDateController.text =
                                      DateFormat('yyyy-mm-dd')
                                          .format(pickeddate);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                  Column(
                    children: [
                      const SizedBox(
                        width: 145,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Contact Number",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 145,
                        child: Form(
                          child: TextFormField(
                            controller: _contactNumberController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "0912...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
              Column(
                children: [
                  const SizedBox(
                    width: 300,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Form(
                      child: TextFormField(
                        controller: _locationController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Address, City, Province",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
              Column(
                children: [
                  const SizedBox(
                    width: 300,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Company Affiliated",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Form(
                      child: TextFormField(
                        controller: _companyController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Unicon Inc.",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your company';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                    vertical: 5,
                  )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Checkbox(
                      side: const BorderSide(color: Colors.white, width: 2),
                      value: termsAndConditions,
                      onChanged: ((value) {
                        setState(() {
                          termsAndConditions = value!;
                        });
                      }),
                    ),
                    const Text(
                      "I agree with the Terms and Conditions provided by Unicon.",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ]),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                    vertical: 5,
                  )),
                  ElevatedButton(
                    onPressed: () {
                      // Checks if the terms and conditions is checked
                      if (termsAndConditions == false) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "OH NO!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "You need to accept terms and conditions.",
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

                        return;
                      }

                      _submitForm();
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
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
  }
}

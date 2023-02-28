import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/navigation_routes.dart';
import '../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MaterialApp(
//     home: RegisterPage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class RegisterPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const RegisterPage({super.key, required this.data});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Future<http.Response> _submitForm() async {
    Map<String, dynamic> userInfo = {
      "name": {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "middleName": _middleNameController.text
      },
      "birthDate": _birthDateController.text,
      "contactNumber": _contactNumberController.text,
      // TODO: Separate addresses by commas
      "location": {
        "address": "Needs implementation",
        "city": "Needs implementation",
        "province": "Needs implementation"
      },
      "company": _companyController.text
    };

    return await register(
        widget.data["accountType"], widget.data["accessToken"], userInfo);
  }

  Future<http.Response> register(
      String accountType, String accessToken, Map<String, dynamic> data) async {
    final uri = Uri.parse("http://localhost:3001/$accountType/register");
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${data["accessToken"]}'
      },
      body: data,
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
            "Please complete your registration.",
            style: TextStyle(color: Colors.grey),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
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
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "DD/MM/YY",
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
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "+63 9...",
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
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Address, City, Province (Use commas ',')",
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
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                      secondary: const Text(
                        "I agree with the Terms and Conditions provided by Unicon.",
                        style: TextStyle(color: Colors.white60),
                      ),
                      value: termsAndConditions,
                      onChanged: (value) {
                        setState(() {
                          termsAndConditions = value!;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _submitForm, child: const Text("Submit")),
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

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/views/provider/company/company_fillup.dart';

import '../../../constants/top_bottom_clippings.dart';

void main() {
  runApp(const MaterialApp(
    home: CompanyUserInfo(email: "", data: <String, dynamic>{"test": "test"}),
    debugShowCheckedModeBanner: false,
  ));
}

class CompanyUserInfo extends StatefulWidget {
  final String email;
  final Map<String, dynamic> data;
  const CompanyUserInfo({super.key, required this.email, required this.data});

  @override
  State<CompanyUserInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyUserInfo> {
  bool termsAndConditions = false;

  // Controllers
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _contactNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            "Please add your basic information.",
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
                                      DateFormat('yyyy-MM-dd')
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
                              hintText: "+63 999 999 9999",
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
                  const Padding(
                      padding: EdgeInsets.symmetric(
                    vertical: 5,
                  )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 35)),
                    onPressed: () {
                      Map<String, dynamic> userInfo = {
                        "email": widget.email,
                        "name": {
                          "firstName": _firstNameController.text,
                          "lastName": _lastNameController.text,
                          "middleName": _middleNameController.text
                        },
                        "birthDate": _birthDateController.text,
                        "contactNumber": _contactNumberController.text,
                        "location": _locationController.text,
                      };

                      // Adds the user info to the data
                      widget.data.addAll(userInfo);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CompanyFillUp(data: widget.data)));
                    },
                    child: const Text(
                      "Next",
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

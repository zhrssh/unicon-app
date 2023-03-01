import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants/navigation_routes.dart';
import '../../constants/top_bottom_clippings.dart';
import 'provider_confirmfill.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: ProviderFillUp(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProviderFillUp extends StatefulWidget {
  const ProviderFillUp({super.key});

  @override
  State<ProviderFillUp> createState() => _ProviderFillUpState();
}

class _ProviderFillUpState extends State<ProviderFillUp> {
  bool TermsAndConditions = false;

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
                  "Fill-up Basic Information",
                  style: TextStyle(color: Colors.grey),
                ),
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5)),
                        Column(
                          children: [
                            const SizedBox(
                              width: 145,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Last Name",
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
                          ],
                        )
                      ],
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                    const SizedBox(
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sex",
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
                            hintText: "Sex",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your sex';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                    Column(
                      children: [
                        const SizedBox(
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Birthdate",
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
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                    Column(
                      children: [
                        const SizedBox(
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Complete Address",
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
                                hintText: "Address, City, Province",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
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
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                          vertical: 5,
                        )),
                        SizedBox(
                          width: 350,
                          child: CheckboxListTile(
                            activeColor: const Color.fromARGB(149, 89, 148, 67),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text(
                              "I agree with the Terms and Conditions provided by Unicon.",
                              style: TextStyle(color: Colors.white60),
                            ),
                            value: TermsAndConditions,
                            onChanged: (value) {
                              setState(() {
                                TermsAndConditions = value!;
                              });
                            },
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 104, 147, 89),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: TermsAndConditions
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProviderConfirmFill()));
                                }
                              : null,
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
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

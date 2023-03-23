import 'package:flutter/material.dart';
import 'package:untitled/views/provider/company/company_confirmfill.dart';
import '../../../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: CompanyFillUp(data: {"test": "test"}),
    debugShowCheckedModeBanner: false,
  ));
}

class CompanyFillUp extends StatefulWidget {
  final Map<String, dynamic> data;
  const CompanyFillUp({super.key, required this.data});

  @override
  State<CompanyFillUp> createState() => _CompanyFillUpState();
}

class _CompanyFillUpState extends State<CompanyFillUp> {
  bool termsAndConditions = false;

  final _registeredNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _lineOfWorkController = TextEditingController();

  @override
  void dispose() {
    _registeredNameController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _lineOfWorkController.dispose();
    super.dispose();
  }

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
                    const SizedBox(
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Registered Company Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Form(
                        child: TextFormField(
                          controller: _registeredNameController,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: "Company Name",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your company name';
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
                              "City / Province",
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
                                hintText: "City / Province",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your city or province';
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
                              controller: _addressController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Address",
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
                        const SizedBox(
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Line of Work",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Form(
                            child: TextFormField(
                              controller: _lineOfWorkController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Line of work",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your line of work';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 12),
                            ),
                            value: termsAndConditions,
                            onChanged: (value) {
                              setState(() {
                                termsAndConditions = value!;
                              });
                            },
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 104, 147, 89),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: termsAndConditions
                              ? () {
                                  Map<String, dynamic> companyInfo = {
                                    "companyInfo": {
                                      "registeredName":
                                          _registeredNameController.text,
                                      "location": _locationController.text,
                                      "address": _addressController.text,
                                      "lineOfWork": _lineOfWorkController.text
                                    }
                                  };

                                  // Adds the user info to the data
                                  widget.data.addAll(companyInfo);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyConfirmFill(
                                                  data: widget.data)));
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

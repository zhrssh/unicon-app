// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/services/upload.dart';
import '../../../constants/navigation_routes.dart';
import '../../../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: CompanyConfirmFill2(data: {"Test": "Test"}, files: {"Test": null}),
    debugShowCheckedModeBanner: false,
  ));
}

class CompanyConfirmFill2 extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<String, File?> files;
  const CompanyConfirmFill2(
      {super.key, required this.data, required this.files});

  @override
  State<CompanyConfirmFill2> createState() => _CompanyConfirmFill2State();
}

class _CompanyConfirmFill2State extends State<CompanyConfirmFill2> {
  File? pcab, dti, bir;

// For uploading an image
  // Function for getting image from gallery
  Future<File?> getImage() async {
    try {
      // Pick an image
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      // convert XFile to File
      final File file = File(image.path);
      return file;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
      return null;
    }
  }

  Future<http.Response> register(
      String accountType, String accessToken, Map<String, dynamic> data) async {
    final uri = Uri.parse(
        "http://${dotenv.env["RSC_URL"]}/api/$accountType/register/company");
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

  void _submitForm() async {
    Map<String, dynamic> providerInfo = {
      "accountType": widget.data["accountType"],
      "accountGroup": widget.data["accountGroup"],
      "name": {
        "firstName": widget.data["name"]["firstName"],
        "lastName": widget.data["name"]["lastName"],
        "middleName": widget.data["name"]["middleName"]
      },
      "birthDate": widget.data["birthDate"],
      "contactNumber": widget.data["contactNumber"],
      "location": widget.data["location"],
      "companyInfo": {
        "registeredName": widget.data["companyInfo"]["registeredName"],
        "location": widget.data["companyInfo"]["location"],
        "address": widget.data["address"],
        "lineOfWork": widget.data["lineOfWork"]
      }
    };

    // Upload user details to the server
    final http.Response response;
    response = await register(
      widget.data["accountType"],
      widget.data["accessToken"],
      providerInfo,
    );

    if (response.statusCode == 200) {
      // Upload images to the server
      // Upload files first to the server

      // Uploads id
      http.StreamedResponse? streamedResponse;
      streamedResponse = await uploadImage(
        widget.data["accessToken"],
        widget.files["id"],
        "provider/register/company/id",
        "id",
      );

      if (streamedResponse.statusCode != 200) {
        // Show error
        // <---HERE--->
        if (kDebugMode) {
          print("Error in uploading file.");
        }
      }

      // Uploads the photoverification in the server
      streamedResponse = await uploadImage(
        widget.data["accessToken"],
        widget.files["photoVerification"],
        "provider/register/company/photo",
        "photo",
      );

      if (streamedResponse.statusCode != 200) {
        // Show error
        // <---HERE--->
        if (kDebugMode) {
          print("Error in uploading file.");
        }
      }

      // Uploads the pcab in the server
      streamedResponse = await uploadImage(
        widget.data["accessToken"],
        pcab,
        "provider/register/company/pcab",
        "pcab",
      );

      if (streamedResponse.statusCode != 200) {
        // Show error
        // <---HERE--->
        if (kDebugMode) {
          print("Error in uploading file.");
        }
      }

      // Uploads the pcab in the server
      streamedResponse = await uploadImage(
        widget.data["accessToken"],
        dti,
        "provider/register/company/dti",
        "dti",
      );

      if (streamedResponse.statusCode != 200) {
        // Show error
        // <---HERE--->
        if (kDebugMode) {
          print("Error in uploading file.");
        }
      }

      // Uploads the pcab in the server
      streamedResponse = await uploadImage(
        widget.data["accessToken"],
        bir,
        "provider/register/company/bir",
        "bir",
      );

      if (streamedResponse.statusCode != 200) {
        // Show error
        // <---HERE--->
        if (kDebugMode) {
          print("Error in uploading file.");
        }
      }

      Navigator.of(context).pop();
      return navigateToLoginPage(context);
    } else {
      if (kDebugMode) {
        print(response.body);
      }

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<Object>(
        builder: (context, snapshot) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/SignupBG.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
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
                    "Confirm Company Identity",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Valid Company Permits",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " (PCAB License, DTI",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 0)),
                            const Text(
                              "Permit, BIR Clearance)",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                      Column(
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              final file = await getImage();
                              if (file == null) return;

                              setState(() {
                                pcab = file;
                              });
                            },
                            icon: const Icon(
                              Icons.file_download_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Attach File (PCAB License)",
                              style: TextStyle(color: Colors.grey),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(300, 45),
                                alignment: Alignment.centerLeft),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0)),
                          TextButton.icon(
                            onPressed: () async {
                              final file = await getImage();
                              if (file == null) return;

                              setState(() {
                                dti = file;
                              });
                            },
                            icon: const Icon(
                              Icons.file_download_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Attach File (DTI Permit)",
                              style: TextStyle(color: Colors.grey),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(300, 45),
                                alignment: Alignment.centerLeft),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0)),
                          TextButton.icon(
                            onPressed: () async {
                              final file = await getImage();
                              if (file == null) return;

                              setState(() {
                                bir = file;
                              });
                            },
                            icon: const Icon(
                              Icons.file_download_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Attach File (BIR Clearance)",
                              style: TextStyle(color: Colors.grey),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(300, 45),
                                alignment: Alignment.centerLeft),
                          )
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 0)),
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: const [
                            Text(
                              "Note: The verification of Identity may take up to 24 hours, for further questions and inquiries, you may use the helpdesk.",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11.5),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 0)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 40),
                          backgroundColor:
                              const Color.fromARGB(255, 104, 147, 89),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () =>
                            _submitForm, //navigate to provider/company homepage
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

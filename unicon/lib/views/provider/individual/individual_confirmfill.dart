// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/services/upload.dart';
import '../../../constants/top_bottom_clippings.dart';
import 'package:http/http.dart' as http;

import '../provider_navigation_routes.dart';

class IndividualConfirmFill extends StatefulWidget {
  final Map<String, dynamic> data;
  const IndividualConfirmFill({super.key, required this.data});

  @override
  State<IndividualConfirmFill> createState() => _IndividualConfirmFillState();
}

class _IndividualConfirmFillState extends State<IndividualConfirmFill> {
  bool termsAndConditions = false;
  File? id_1, photoVerification;

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

  Future<File?> getImageFromCamera() async {
    try {
      // Pick an image
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
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

  void _submitForm() async {
    Map<String, dynamic> userInfo = {
      "email": widget.data["email"],
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
    };

    // Upload user details to the server
    final http.Response response;
    response = await register(
      widget.data["accountType"],
      widget.data["accessToken"],
      userInfo,
    );

    if (response.statusCode == 200) {
      // Upload images to the server
      // Upload files first to the server
      http.StreamedResponse? streamedResponse;
      streamedResponse = await uploadImage(
        widget.data["accessToken"],
        id_1,
        "provider/register/individual/id",
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
        photoVerification,
        "provider/register/individual/photo",
        "photo",
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

      return;
    }
  }

  Future<http.Response> register(
      String accountType, String accessToken, Map<String, dynamic> data) async {
    final uri = Uri.parse(
        "http://${dotenv.env["RSC_URL"]}/api/$accountType/register/individual");
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
      resizeToAvoidBottomInset: false,
      body: Center(
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
                      height: 130,
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
              "Confirm Identification",
              style: TextStyle(color: Colors.grey),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
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
                            "1 Valid Government ID",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " (Driver’s License,",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
                      const Text(
                        "National ID, PhilHealth, Postal ID, NBI ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
                      const Text(
                        "Clearance)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                Column(
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final file = await getImage();
                        if (file == null) return;

                        setState(() {
                          id_1 = file;
                          if (kDebugMode) {
                            print("Attachment 1: $id_1");
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.file_download_outlined,
                        color: Colors.black,
                      ),
                      label: Text(
                        id_1 == null ? "Attach File" : "Ready to upload!",
                        style: const TextStyle(
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(300, 45),
                          alignment: Alignment.centerLeft),
                    ),
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0)),
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Photo Verification",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " (Copy the man's hand",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
                      const Text(
                        "position in the picture below)",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/left-handed-man-verification.png',
                            width: 131,
                            height: 113,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: const Size(135, 113),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () async {
                              final file = await getImageFromCamera();
                              if (file == null) return;

                              setState(() {
                                photoVerification = file;
                                if (kDebugMode) {
                                  print(
                                      "Photo Verification: $photoVerification");
                                }
                              });
                            },
                            child: photoVerification == null
                                ? const Icon(
                                    Icons.file_download_outlined,
                                    size: 60,
                                    color: Colors.black,
                                  )
                                : Image.asset(
                                    "assets/icons/check_icon.png",
                                    height: 60,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0)),
                SizedBox(
                  width: 300,
                  child: Column(
                    children: const [
                      Text(
                        "Note: The verification of Identity may take up to 24 hours, for further questions and inquiries, you may use the helpdesk.",
                        style: TextStyle(color: Colors.grey, fontSize: 11.5),
                      )
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 40),
                    backgroundColor: const Color.fromARGB(255, 104, 147, 89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed:
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
          ]),
        ),
      ),
    );
  }
}

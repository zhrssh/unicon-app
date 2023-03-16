import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Upload the image to the server
Future<http.StreamedResponse> uploadImage(
    File? file, String path, String fieldname) async {
  final request = http.MultipartRequest(
      "POST", Uri.parse("http://${dotenv.env["RSC_URL"]}/api/provider$path"));

  request.files.add(http.MultipartFile.fromBytes(
      fieldname, File(file!.path).readAsBytesSync()));

  // Request to upload to server
  final response = await request.send();
  if (response.statusCode == 200) {
    if (kDebugMode) {
      print("Uploaded successfully.");
    }
  }

  return response;
}

// Upload multiple images to the server
Future<http.StreamedResponse?> uploadImageMultiple(
  List<File?> files,
  String path,
  String fieldname,
) async {
  final request = http.MultipartRequest(
      "POST", Uri.parse("http://${dotenv.env["RSC_URL"]}/api/provider$path"));

  final length = files.length;
  if (length > 0) {
    // Add files to be uploaded
    for (var i = 0; i < length; i++) {
      request.files.add(http.MultipartFile.fromBytes(
          fieldname, File(files[i]!.path).readAsBytesSync()));
    }

    // Request to upload to server
    final response = await request.send();
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Uploaded successfully.");
      }
    }

    return response;
  } else {
    return null;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Upload the image to the server
Future<http.StreamedResponse> uploadImage(
    String accessToken, File? file, String path, String fieldname) async {
  final request = http.MultipartRequest(
    "POST",
    Uri.parse("http://${dotenv.env["RSC_URL"]}/api/$path"),
  );

  request.headers.addAll(<String, String>{
    "Content-type": "multipart/form-data",
    'Authorization': 'Bearer $accessToken'
  });

  // Image information
  final fileStream = http.ByteStream(file!.openRead());
  final fileLength = await file.length();
  final multipartFile = http.MultipartFile(fieldname, fileStream, fileLength);
  request.files.add(multipartFile);

  // Request to upload to server
  final response = await request.send();

  if (kDebugMode) {
    final responseBody = await response.stream.bytesToString();
    print(responseBody);
  }

  if (response.statusCode == 200) {
    if (kDebugMode) {
      print("Uploaded successfully.");
    }
  }

  return response;
}

// Upload multiple images to the server
Future<http.StreamedResponse?> uploadImageMultiple(
  String accessToken,
  List<File?> files,
  String path,
  String fieldname,
) async {
  final request = http.MultipartRequest(
      "POST", Uri.parse("http://${dotenv.env["RSC_URL"]}/api/$path"));

  final length = files.length;
  if (length > 0) {
    // Add headers
    request.headers.addAll(<String, String>{
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $accessToken'
    });

    // Add files to be uploaded
    for (File? file in files) {
      if (file == null) {
        continue;
      }

      final fileStream = http.ByteStream(file.openRead());
      final fileLength = await file.length();
      final multipartFile =
          http.MultipartFile(fieldname, fileStream, fileLength);
      request.files.add(multipartFile);
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

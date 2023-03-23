import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

// Upload the image to the server
Future<http.StreamedResponse> uploadImage(
    String accessToken, File? file, String path, String fieldname) async {
  final request = http.MultipartRequest(
    "POST",
    Uri.parse("http://${dotenv.env["RSC_URL"]}/api/$path"),
  );

  final lastIndex = file!.path.lastIndexOf('.');
  final ext = file.path.substring(lastIndex);

  request.headers
      .addAll(<String, String>{"'authorization'": 'Bearer $accessToken'});

  // Image information
  request.files.add(
    await http.MultipartFile.fromPath(
      fieldname,
      file.path,
      contentType: MediaType('image', ext),
    ),
  );

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
    "POST",
    Uri.parse("http://${dotenv.env["RSC_URL"]}/api/$path"),
  );

  final length = files.length;
  if (length > 0) {
    // Add headers
    request.headers
        .addAll(<String, String>{"'authorization'": 'Bearer $accessToken'});

    // Add files to be uploaded
    for (File? file in files) {
      if (file == null) {
        continue;
      }

      final lastIndex = file.path.lastIndexOf('.');
      final ext = file.path.substring(lastIndex);

      request.files.add(
        await http.MultipartFile.fromPath(
          fieldname,
          file.path,
          contentType: MediaType('image', ext),
        ),
      );
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

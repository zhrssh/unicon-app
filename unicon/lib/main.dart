import 'package:flutter/material.dart';
import 'package:untitled/views/client/homepage/client_dashboard.dart';
import 'package:untitled/views/client/homepage/client_home.dart';
import 'package:untitled/views/provider/homepage/provider_home.dart';
import 'views/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await [Permission.storage].request();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

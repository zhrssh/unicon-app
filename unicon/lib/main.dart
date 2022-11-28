import 'package:flutter/material.dart';
import 'package:unicon/responsive/responsive_layout.dart';
import 'package:unicon/src/homepage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: ResponsiveLayout(
        mobileScaffold: const MobilePage(),
        tabletScaffold: const TabletPage(),
        desktopScaffold: const DesktopPage(),
      ),
    );
  }
}

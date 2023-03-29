import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClientProjectDetails extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String location;
  final String about;
  const ClientProjectDetails(
      {super.key,
      required this.image,
      required this.title,
      required this.date,
      required this.location,
      required this.about});

  @override
  State<ClientProjectDetails> createState() => _ClientProjectDetailsState();
}

class _ClientProjectDetailsState extends State<ClientProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ));
  }
}

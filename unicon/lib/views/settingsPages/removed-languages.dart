import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});
  @override
  State<LanguagePage> createState() => _LanguagePageState();
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Settings',
      debugShowCheckedModeBanner: false,
    );
  }
}

class _LanguagePageState extends State<LanguagePage> {
  String language = "EN-US";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "Language",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          toolbarHeight: 75.0,
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const ListTile(
              title: Text(
                "Suggested",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text("English (US)"),
              trailing: Radio(
                  value: "EN-US",
                  groupValue: language,
                  activeColor: const Color.fromARGB(255, 84, 122, 70),
                  onChanged: (value) {
                    setState(() {
                      language = value.toString();
                    });
                  }),
            ),
            ListTile(
              title: const Text("English (UK)"),
              trailing: Radio(
                  value: "EN-UK",
                  groupValue: language,
                  activeColor: const Color.fromARGB(255, 84, 122, 70),
                  onChanged: (value) {
                    setState(() {
                      language = value.toString();
                    });
                  }),
            )
          ],
        ));
  }
}

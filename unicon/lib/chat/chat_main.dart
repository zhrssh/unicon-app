import 'package:flutter/material.dart';
import 'package:untitled/chat/screens/chat_homepage.dart';

void main() {
  runApp(const ChatSys());
}

class ChatSys extends StatelessWidget {
  const ChatSys({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

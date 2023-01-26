import 'package:flutter/material.dart';
import 'package:untitled/chat/screens/chatpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatPage(),
    );
  }
}

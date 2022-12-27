import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  final String displayedText;

  const Email({super.key, required this.displayedText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        hintText: displayedText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      obscureText: showPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.visibility_off),
          color: Colors.black45,
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
        hintText: 'Password',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}

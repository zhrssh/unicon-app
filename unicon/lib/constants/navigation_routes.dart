import 'package:flutter/material.dart';
import '../views/homepage.dart';
import '../views/login.dart';
import '../views/resetpw.dart';
import '../views/signup.dart';
import '../views/verify.dart';

Future navigateToSignUpPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SignUpPage()));
}

Future navigateToHomePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const HomePage()));
}

Future navigateToResetPWPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ResetPWPage()));
}

Future navigateToLoginPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

Future navigateToVerifyPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const VerifyPage()));
}

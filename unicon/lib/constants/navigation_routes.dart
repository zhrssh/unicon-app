import 'package:flutter/material.dart';
import '../views/calendar.dart';
import '../views/homepage.dart';
import '../views/location.dart';
import '../views/login.dart';
import '../views/profile.dart';
import '../views/resetpw.dart';
import '../views/signup_v2.dart';
import '../views/verify.dart';

Future navigateToSignUpPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SignupPage()));
}

Future navigateToHomePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Dashboard()));
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

Future navigateToCalendarPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const CalendarPage()));
}

Future navigateToLocationPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LocationPage()));
}

Future navigateToProfilePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfilePage()));
}

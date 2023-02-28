import 'package:flutter/material.dart';
import '../views/calendar.dart';
import '../views/home.dart';
import '../views/dashboard.dart';
import '../views/location.dart';
import '../views/login.dart';
import '../views/profile.dart';
import '../views/resetpw.dart';
import '../views/signup_v2.dart';
import '../views/verify.dart';
import '../views/regtype.dart';
import '../views/register.dart';

Future navigateToRegisterPage(context, Map<String, dynamic> data) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => RegisterPage(data: data)));
}

Future navigateToSignUpPage(context, Map<String, dynamic> data) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignupPage(data: data)));
}

Future navigateToHome(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Home()));
}

Future navigateToDashboard(context) async {
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

Future navigateToVerifyPage(
    context, String uuid, Map<String, dynamic> data) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VerifyPage(uuid: uuid, data: data)));
}

Future navigateToCalendarPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const CalendarPage()));
}

Future navigateToLocationPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LocationPage()));
}

Future navigateToProfilePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ProfilePage()));
}

Future navigateToRegTypePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const RegTypePage()));
}

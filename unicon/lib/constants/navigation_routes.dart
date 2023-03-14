import 'package:flutter/material.dart';
import 'package:untitled/views/provider/company/publish_project.dart';
import 'package:untitled/views/settingsPages/notifications.dart';
import '../views/calendar.dart';
import '../views/client/client_home.dart';
import '../views/dashboard.dart';
import '../views/location.dart';
import '../views/login.dart';
import '../views/notifications_page.dart';
import '../views/profile.dart';
import '../views/provider/provider_regtype.dart';
import '../views/resetpw.dart';
import '../views/signup_v2.dart';
import '../views/verify.dart';
import '../views/regtype.dart';
import '../views/client/client_register.dart';

void navigateToRegisterPage(context, Map<String, dynamic> data) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => RegisterPage(data: data)));
}

void navigateToSignUpPage(context, Map<String, dynamic> data) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignupPage(data: data)));
}

void navigateToHome(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Home()));
}

void navigateToDashboard(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Dashboard()));
}

void navigateToResetPWPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ResetPWPage()));
}

void navigateToLoginPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

void navigateToVerifyPage(
    context, String uuid, String email, Map<String, dynamic> data) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              VerifyPage(uuid: uuid, email: email, data: data)));
}

void navigateToCalendarPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const CalendarPage()));
}

void navigateToLocationPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LocationPage()));
}

void navigateToProfilePage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ProfilePage()));
}

void navigateToRegTypePage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const RegTypePage()));
}

void navigateToPublishProjectPage(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const PublishProjectPage()));
}

void navigateToNotification(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const NotificationPage()));
}

void navigateToNotificationSettingsPage(context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const NotificationSettingsPage()));
}

void navigateToProviderRegType(context, Map<String, dynamic> data) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProviderRegType(data: data)));
}

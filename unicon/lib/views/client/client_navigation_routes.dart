import 'package:flutter/material.dart';
import 'package:untitled/views/client/chat/screens/chat_homepage.dart';
import 'package:untitled/views/client/chat/screens/chatpage.dart';
import 'package:untitled/views/client/views/client_calendar.dart';
import 'package:untitled/views/client/views/publish_project.dart';
import 'package:untitled/views/settingsPages/notifications.dart';
import '../login.dart';
import '../notifications_page.dart';
import '../regtype.dart';
import '../resetpw.dart';
import '../signup_v2.dart';
import '../verify.dart';
import 'client_register.dart';
import 'homepage/client_home.dart';
import 'homepage/client_profile.dart';

///////////////// REGISTRATION ///////////////////
void navigateToClientRegisterInfoPage(
    context, String email, Map<String, dynamic> data) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ClientRegisterInfoPage(email: email, data: data)));
}

void navigateToResetPWPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ResetPWPage()));
}

void navigateToSignUpPage(context, Map<String, dynamic> data) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignupPage(data: data)));
}

void navigateToVerifyPage(
    context, String uuid, String email, Map<String, dynamic> data) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              VerifyPage(uuid: uuid, email: email, data: data)));
}

void navigateToRegTypePage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const RegTypePage()));
}

///////////////// LOGIN ///////////////////
void navigateToLoginPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

///////////////// CLIENT ///////////////////
void navigateToClientHome(context, String token) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ClientHome(token: token)));
}

void navigateToClientCalendarPage(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ClientCalendarPage()));
}

void navigateToClientProfilePage(context, String token) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ClientProfilePage(token: token)));
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

void navigateToClientChatPage(context, String token) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ClientChatPage(token: token)));
}

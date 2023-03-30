import 'package:flutter/material.dart';

import '../login.dart';
import '../notifications_page.dart';
import '../settingsPages/notifications.dart';
import 'homepage/provider_home.dart';
import 'homepage/provider_profile.dart';
// import 'package:untitled/views/client/chat/screens/chat_homepage.dart';
// import 'package:untitled/views/client/views/publish_project.dart';
// import 'package:untitled/views/settingsPages/notifications.dart';
// // import '../views/calendar.dart';
// // import '../views/client/homepage/client_home.dart';
// // import '../views/client/homepage/client_profile.dart';
// // import '../views/client/views/client_calendar.dart';
// // import '../views/dashboard.dart';
// // import '../views/location.dart';
// // import '../views/login.dart';
// // import '../views/notifications_page.dart';
// // import '../views/provider/homepage/provider_profile.dart';
// // import '../views/provider/homepage/provider_home.dart';
// // import '../views/provider/provider_regtype.dart';
// // import '../views/resetpw.dart';
// // import '../views/signup_v2.dart';
// // import '../views/verify.dart';
// // import '../views/regtype.dart';
// // import '../views/client/client_register.dart';
// // import '../views/client/chat/screens/chatpage.dart';

// ///////////////// REGISTRATION ///////////////////
// void navigateToClientRegisterInfoPage(
//     context, String email, Map<String, dynamic> data) {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               ClientRegisterInfoPage(email: email, data: data)));
// }

// void navigateToResetPWPage(context) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => const ResetPWPage()));
// }

// void navigateToSignUpPage(context, Map<String, dynamic> data) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => SignupPage(data: data)));
// }

// void navigateToVerifyPage(
//     context, String uuid, String email, Map<String, dynamic> data) {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               VerifyPage(uuid: uuid, email: email, data: data)));
// }

// void navigateToRegTypePage(context) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => const RegTypePage()));
// }

// void navigateToProviderRegType(
//     context, String email, Map<String, dynamic> data) {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ProviderRegType(email: email, data: data)));
// }

// ///////////////// LOGIN ///////////////////
void navigateToLoginPage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

// ///////////////// CLIENT ///////////////////
// void navigateToClientHome(context, String token) {
//   Navigator.push(context,
//       MaterialPageRoute(builder: (context) => ClientHome(token: token)));
// }

// ///////////////// PROVIDER ///////////////////
void navigateToProviderHome(context, String token) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProviderHome(token: token)));
}

// // void navigateToDashboard(context) {
// //   Navigator.push(
// //       context, MaterialPageRoute(builder: (context) => const Dashboard()));
// // }

// void navigateToCalendarPage(context) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => const CalendarPage()));
// }

// void navigateToClientCalendarPage(context) {
//   Navigator.push(context,
//       MaterialPageRoute(builder: (context) => const ClientCalendarPage()));
// }

// // void navigateToLocationPage(context) {
// //   Navigator.push(
// //       context, MaterialPageRoute(builder: (context) => const ClientChatPage()));
// // }

void navigateToProfilePage(context, String token) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProviderProfilePage(token: token)));
}

// void navigateToClientProfilePage(context, String token) {
//   Navigator.push(context,
//       MaterialPageRoute(builder: (context) => ClientProfilePage(token: token)));
// }

// void navigateToPublishProjectPage(context) {
//   Navigator.push(context,
//       MaterialPageRoute(builder: (context) => const PublishProjectPage()));
// }

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

// ///////////////// CHAT SYSTEM ///////////////////
// // void navigateToClientChatPage(context) {
// //   Navigator.push(context,
// //       MaterialPageRoute(builder: (context) => const ClientChatHomePage()));
// // }

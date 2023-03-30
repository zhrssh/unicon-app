import 'package:flutter/material.dart';
import '../views/client/homepage/client_home.dart';
import '../views/login.dart';
import '../views/provider/homepage/provider_home.dart';
import '../views/provider/provider_regtype.dart';
import '../views/resetpw.dart';
import '../views/signup_v2.dart';
import '../views/verify.dart';
import '../views/regtype.dart';
import '../views/client/client_register.dart';

// ///////////////// REGISTRATION ///////////////////
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

void navigateToProviderRegType(
    context, String email, Map<String, dynamic> data) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProviderRegType(email: email, data: data)));
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

/////////////// PROVIDER ///////////////////
void navigateToProviderHome(context, String token) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProviderHome(token: token)));
}

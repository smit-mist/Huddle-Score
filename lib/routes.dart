import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/password_assist_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/sign_in_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/sign_up_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routeGenerator = {
  'welcome': (context) => WelcomeScreen(),
  'sign_in': (context) => SignInScreen(),
  'sign_up': (context) => SignUpScreen(),
  'password_assist': (context) => PasswordAssistInitialScreen(),
  'home': (context) => HomeNavBar(),
};

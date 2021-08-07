import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/password_assist_screen.dart';
import 'package:huddle_and_score/screens/sign_in_screen.dart';
import 'package:huddle_and_score/screens/sign_up_screen.dart';
import 'package:huddle_and_score/screens/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routeGenerator = {
  'welcome': (context) => WelcomeScreen(),
  'sign_in':(context) =>SignInScreen(),
  'sign_up':(context)=>SignUpScreen(),
  'password_assist':(context)=>PasswordAssistScreen(),
  'home':(context)=>HomeNavBar(),
};
import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/sign_in_screen.dart';
import 'package:huddle_and_score/screens/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routeGenerator = {
  'welcome': (context) => WelcomeScreen(),
  'sign_in':(context) =>SignInScreen(),
};
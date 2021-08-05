import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/welcome_screen.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:kThemeColor,
      ),
      home: WelcomeScreen(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';

class UserTermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h * 0.95,
        width: w,
        child: Column(
          children: [
            Text(
              'USER TERMS AND CONDITIONS- Huddle & Score',
              style: themeFont(),
            ),
          ],
        ),
      ),
    );
  }
}

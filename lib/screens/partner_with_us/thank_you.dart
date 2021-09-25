import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';

import '../../constants.dart';

class ThankYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return CommonScaffold(
      bottomBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: w,
        height: h * 0.08,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 1)
        ]),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeNavBar()));
              },
              child: Text(
                'Back to Home',
                style: themeFont(),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h*0.08,),

            Text(
              'Your details have been recorded!',
              style: themeFont(
                s: 23,
                color: kThemeColor,
              ),
            ),
            SizedBox(height: h*0.075,),
            Icon(
              Icons.check_circle,
              color: kThemeColor,
              size: 100,
            ),
            SizedBox(height: h*0.1,),

            Text(
              'Thank you for your interest!',
              style: themeFont(
                s: 23,
                color: kThemeColor,
              ),
            ),
            SizedBox(height: h*0.025,),
            Text(
              'One of our business executives will get in touch with you to take it forward.',
              textAlign: TextAlign.center,
              style: themeFont(s: 18),
            ),

          ],
        ),
      ),
    );
  }
}

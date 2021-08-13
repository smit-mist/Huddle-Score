import 'package:flutter/material.dart';

import '../../constants.dart';

class ThankYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
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
                  Navigator.pop(context);
                },
                child: Text(
                  'Back to home',
                  style: themeFont(),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Your details have been recorded!',
                style: themeFont(
                  s: 23,
                  color: kThemeColor,
                ),
              ),
              Icon(Icons.check_circle,color: kThemeColor,size: 100,),
              Text(
                'Thank You for your interest!',
                style: themeFont(
                  s: 23,
                  color: kThemeColor,
                ),
              ),
              Text(
                'One of our business executives will get in touch with you to take it forward.',
                textAlign: TextAlign.center,
                style: themeFont(s: 18),
              ),
              SizedBox(height: h*0.2,),
            ],
          ),
        ),
      ),
    );
  }
}

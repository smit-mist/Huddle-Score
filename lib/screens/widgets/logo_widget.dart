import 'package:flutter/material.dart';

import '../../constants.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/huddle_logo.png',
          height: h * 0.13,
          width: w * 0.15,
          //height: h * 0.3,
        ),
        Text(
          'Huddle & Score',
          style: themeFont(
            s: 26,
            color: kThemeColor,
            w: 'b',
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';

import '../home_navbar_screen.dart';
import '../static_screens/user_tnc.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // print('=================');
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return CommonScaffold(
      child: Container(
        width: w,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h*(232/kScreenH),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/huddle_logo.png',
                    height: h * 0.13,
                    width: w*0.17,
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
              ),
              SizedBox(
                height: 5,
              ),
              Spacer(),
              ActionButton(
                child: Text(
                  'Sign Up',
                  style: themeFont(color: Colors.white, w: 'm', s: 16),
                ),
                bgColor: kThemeColor,
                onTap: () {
                  Navigator.pushNamed(context, 'sign_up');
                },
              ),
              SizedBox(
                height: 10,
              ),
              ActionButton(
                child: Text(
                  'Log In',
                  style: themeFont(color: kThemeColor, w: 'm', s: 16),
                ),
                bgColor: Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, 'sign_in');
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'from',
                style: GoogleFonts.syne(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              Text(
                'GROWNITED',
                style: GoogleFonts.syne(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

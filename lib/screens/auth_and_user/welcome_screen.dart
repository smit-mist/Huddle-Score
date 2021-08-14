import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../home_navbar_screen.dart';

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

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: w,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeNavBar(),
                          ),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: themeFont(
                          color: kThemeColor,
                          w: FontWeight.normal,
                          s: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/huddle_logo.jpeg',
                  height: h * 0.3,
                ),
                SizedBox(
                  height: 5,
                ),
                Spacer(),
                ActionButton(
                  child: Text(
                    'Sign Up',
                    style: themeFont(
                        color: Colors.white, w: FontWeight.normal, s: 16),
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
                    'Login',
                    style: themeFont(
                        color: kThemeColor, w: FontWeight.normal, s: 16),
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
                      fontSize: 13),
                ),
                Text(
                  'GROWNITED',
                  style: GoogleFonts.syne(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

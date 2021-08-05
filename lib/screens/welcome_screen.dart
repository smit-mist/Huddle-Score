import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Skip',
                      style: themeFont(
                        color: kThemeColor,
                        w: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Image.network(
                  'https://picsum.photos/70/100',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Huddle & Score',
                  style: themeFont(color: Colors.black, w: FontWeight.bold)
                      .copyWith(fontStyle: FontStyle.italic, fontSize: 20),
                ),
                Spacer(),
                ActionButton(
                  child: Text(
                    'Sign Up',
                    style: themeFont(color: Colors.white, w: FontWeight.normal),
                  ),
                  bgColor: kThemeColor,
                  onTap: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                ActionButton(
                  child: Text(
                    'Login',
                    style: themeFont(color: kThemeColor, w: FontWeight.normal),
                  ),
                  bgColor: Colors.white,
                  onTap: () {},
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'from',
                  style: themeFont(color: Colors.black, w: FontWeight.w400),
                ),
                Text(
                  'GROWNITED',
                  style: themeFont(color: Colors.black, w: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

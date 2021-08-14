import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/screens/auth_and_user/sign_in_screen.dart';

import '../../constants.dart';

class AnonymousProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: h * (63 / kScreenH),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SignInScreen(),
                ),
              );
            },
            child: Container(
              height: h * (65 / kScreenH),
              width: w * (348 / kScreenW),
              decoration: BoxDecoration(
                color: kThemeColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Stack(
                children: [
                  Align(
                    child: Text(
                      'Sign In',
                      style: themeFont(
                        s: 18,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          child: Icon(
                            Icons.account_circle_rounded,
                            color: kThemeColor,
                            size: 40,
                          ),
                          height: w * (55 / kScreenW),
                          width: w * (55 / kScreenW),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            height: h * 0.3,
            width: w * 0.9,
            child: ListView(
              children: [
                IgnorePointer(
                  child: ExpansionTile(
                    title: Text(
                      'Account',
                      style: themeFont(color: Colors.grey.withOpacity(0.6)),
                    ),
                    leading: Icon(Icons.exit_to_app_sharp,
                        color: Colors.grey.withOpacity(0.6)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                ),
                Divider(),
                ExpansionTile(
                  title: Text(
                    'Help & Support',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.notifications_none,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
                Divider(),
                ExpansionTile(
                  title: Text(
                    'About',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.add_circle_outline,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
          Spacer(),
          Text(
            'from',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
          ),
          Text(
            'GROWNITED',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/screens/auth_and_user/about_app_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/edit_profile_screen.dart';

import '../../constants.dart';
import '../home_navbar_screen.dart';
import 'help_and_support_screen.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  UserProfileScreen({this.email, this.name});

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
          Container(
            height: h * (65 / kScreenH),
            width: w * (348 / kScreenW),
            child: Row(
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://picsum.photos/300/200',
                    width: w * (74 / kScreenW),
                    height: h * (56 / kScreenH),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, ${name}',
                      style: themeFont(
                        color: kThemeColor,
                        s: 20,
                      ),
                    ),
                    Text(
                      '${email}',
                      style: themeFont(
                        color: Colors.red,
                        s: 10,
                      ),
                    )
                  ],
                )
              ],
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
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EditProfileScreen(email: email,name: name,)));
                  },
                  title: Text(
                    'Account',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.exit_to_app_sharp,
                  ),
                  trailing: Container(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HelpAndSupportScreen(),
                      ),
                    );
                  },
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
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AboutAppScreen(),
                      ),
                    );
                  },
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

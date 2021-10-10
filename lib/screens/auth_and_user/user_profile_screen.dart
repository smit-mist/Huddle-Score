import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/screens/static_screens/about_app_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/edit_profile_screen.dart';

import '../../constants.dart';
import '../static_screens/help_and_support_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  UserProfileScreen({this.email, this.name});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    bool verified = FirebaseAuth.instance.currentUser.emailVerified;
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
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.person_sharp,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, ${widget.name}',
                      style: themeFont(
                        color: kThemeColor,
                        s: 20,
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text(
                      '${widget.email}',
                      style: themeFont(
                        color: verified ? kThemeColor : Colors.red,
                        s: 12,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditProfileScreen(
                                  email: widget.email,
                                  name: widget.name,
                                )));
                  },
                  title: Text(
                    'Account',
                    style: themeFont(),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/Account_Profile.svg',
                    height: 15,
                    width: 15,
                  ),
                  trailing: Container(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (verified)
                            ? Container()
                            : Icon(
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
                  leading: SvgPicture.asset(
                    'assets/icons/New_Help.svg',
                    height: 17,
                    width: 17,
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
                  leading: SvgPicture.asset(
                    'assets/icons/New_About.svg',
                    height: 17,
                    width: 17,
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
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          Text(
            'GROWNITED',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

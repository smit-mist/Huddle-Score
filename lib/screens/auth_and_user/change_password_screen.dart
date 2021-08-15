import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/auth_and_user/password_assist_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../../constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  Text(
                    'Change Password',
                    style: themeFont(color: kThemeColor, s: 23),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Current Password',
                style: themeFont(),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                style: themeFont(
                  color: Colors.black,
                  w: FontWeight.normal,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your current Password',
                  hintStyle: themeFont(
                      color: Color(0xff626262), w: FontWeight.normal, s: 14),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      (false == false
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: (false == true)
                          ? kThemeColor
                          : Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: kThemeColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: themeFont(s: 12),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PasswordAssistInitialScreen(),
                          ),
                        );
                      }),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'New Password',
                style: themeFont(),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                style: themeFont(
                  color: Colors.black,
                  w: FontWeight.normal,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your new Password',
                  hintStyle: themeFont(
                      color: Color(0xff626262), w: FontWeight.normal, s: 14),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      (false == false
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: (false == true)
                          ? kThemeColor
                          : Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: kThemeColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: w * (356 / kScreenW),
                child: Text(
                  'Password should be at least 6 characters long and must include at least 1 number. Ex. @,\$,%,!.',
                  style: themeFont(
                    color: Colors.black,
                    s: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Confrim New Password',
                style: themeFont(),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                style: themeFont(
                  color: Colors.black,
                  w: FontWeight.normal,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Re-enter your new Password',
                  hintStyle: themeFont(
                      color: Color(0xff626262), w: FontWeight.normal, s: 14),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      (false == false
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: (false == true)
                          ? kThemeColor
                          : Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: kThemeColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.07,
              ),
              Container(
                width: double.infinity,
                height: 42,
                child: ActionButton(
                  child: Text(
                    'Save Changes',
                    style: themeFont(
                      color: Colors.white,
                    ),
                  ),
                  bgColor: kThemeColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

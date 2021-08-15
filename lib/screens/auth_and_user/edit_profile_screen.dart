import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';

class EditProfileScreen extends StatelessWidget {
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
              SizedBox(height: 40,),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  Text(
                    'Account',
                    style: themeFont(color: kThemeColor, s: 23),
                  ),
                ],
              ),
              SizedBox(height: 30,),

              Text(
                'Full Name',
                style: themeFont(),
              ),
              SizedBox(height: 10,),

              TextField(
                decoration: normalTextDecoration('Test User').copyWith(
                  suffixIcon: Icon(
                    Icons.edit,
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Text(
                'Email ID',
                style: themeFont(),
              ),
              SizedBox(height: 10,),

              TextField(
                style: themeFont(color: Colors.redAccent,),
                decoration: normalTextDecoration('test@gmail.com').copyWith(hintStyle: themeFont(color: Colors.redAccent,)),
              ),
              SizedBox(height: 5,),

              Row(
                children: [
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      style: themeFont(),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                          'Email not verified! ',
                          style: themeFont(color: Colors.redAccent,s: 12)
                        ),
                        TextSpan(
                          text: 'Verify Email',
                          style: themeFont(
                            color: kThemeColor,s: 12
                          ).copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Change Password',
                style: themeFont().copyWith(decoration: TextDecoration.underline),
              ),
              SizedBox(height: 5,),

              Text(
                'Log Out',
                style: themeFont().copyWith(decoration: TextDecoration.underline),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

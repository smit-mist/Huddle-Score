import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../constants.dart';

class PasswordAssistScreen extends StatefulWidget {
  @override
  _PasswordAssistScreenState createState() => _PasswordAssistScreenState();
}

class _PasswordAssistScreenState extends State<PasswordAssistScreen> {
  bool isEmail = false;
  String email = "";
  int state = 0;
  // 0 - error
  // 1 - default
  // 2 - success
  @override
  Widget build(BuildContext context) {
    print(state);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/huddle_logo.jpeg',
                    height: h * 0.1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password Assistance',
                    style: themeFont(color: kThemeColor, s: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Get back into your account with 2 quick steps!',
                    style: themeFont(
                      s: 12,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Enter the registered Email id to receive a link',
                    style: themeFont(s: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w * (356 / kScreenW),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isEmail = true;
                        });
                      },
                      onChanged: (String a) {
                        setState(() {
                          email = a;
                        });
                      },
                      style: themeFont(
                        color: Colors.black,
                        w: FontWeight.normal,
                      ),
                      decoration: normalTextDecoration(isEmail, 'Email id'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: w * (356 / kScreenW),
                    height: 20,
                    child: Row(
                      children: [
                        Text(
                          (state ==0 ? 'Invalid Email-id!' : ''),
                          style: themeFont(color: Colors.red, s: 12),
                        ),
                        (state ==2?Spacer():SizedBox(width: 1,)),
                        Text(
                          (state == 2?'Didn\'t receive an email? ':''),
                          style: themeFont(s: 13),
                        ),
                        Text(
                          (state == 2?'Resend':''),
                          style: themeFont(s: 13).copyWith(color: kThemeColor,decoration: TextDecoration.underline),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: w * (356 / kScreenW),
                    height: 30,
                    child: Text(
                      (state ==0
                          ? 'Please make sure you enter an email id that is associated with your Huddle & Score account.'
                          : ''),
                      style: themeFont(
                        color: Colors.grey.withOpacity(0.7),
                        s: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.2),
                  ActionButton(
                    bgColor: kThemeColor,
                    child: Text(
                      'Submit',
                      style: themeFont(
                        color: Colors.white,
                        w: FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        state++;state%=3;
                        // above state is just for testing used it as you want.
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

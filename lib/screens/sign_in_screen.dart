import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = "", password = "";
  bool isEmail = false, isPass = false, obscureText = true;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/huddle_logo.jpeg',
                    height: h * 0.2,
                  ),
                  SizedBox(
                    height: 20,
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w * (356 / kScreenW),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isPass = true;
                        });
                      },
                      onChanged: (String a) {
                        setState(() {
                          password = a;
                        });
                      },
                      style: themeFont(
                        color: Colors.black,
                        w: FontWeight.normal,
                      ),
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: themeFont(
                            color: Color(0xff626262),
                            w: FontWeight.normal,
                            s: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Icon(
                            (obscureText == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: (isPass == true)
                                ? kThemeColor
                                : Colors.grey.withOpacity(0.4),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: (isPass == false
                              ? BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )
                              : BorderSide(
                                  width: 2,
                                  color: kThemeColor,
                                )),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: (isPass == false
                              ? BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )
                              : BorderSide(
                                  width: 2,
                                  color: kThemeColor,
                                )),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context, 'password_assist');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: themeFont(
                                color: kThemeColor, w: FontWeight.normal, s: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ActionButton(
                    bgColor: kThemeColor,
                    child: Text(
                      'Log In',
                      style: themeFont(
                        color: Colors.white,
                        w: FontWeight.normal,
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, 'home');
                    },
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New to Huddle & Score?', style: themeFont(s: 13)),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, 'sign_up');

                        },
                        child: Text(
                          'Sign up',
                          style: themeFont(
                            s: 13,
                            color: kThemeColor,
                          ),
                        ),
                      )
                    ],
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

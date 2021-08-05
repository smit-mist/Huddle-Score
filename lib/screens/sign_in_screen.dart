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
                  Container(
                    width: w*0.82,
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
                        color: kThemeColor,
                        w: FontWeight.normal,
                      ),
                      decoration: normalTextDecoration(isEmail, 'Email id'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w*0.82,
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
                        color: kThemeColor,
                        w: FontWeight.normal,
                      ),
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                        contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
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
                      Text(
                        'Forgot Password?',
                        style: themeFont(
                          color: kThemeColor,
                          w: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ActionButton(
                    bgColor: kThemeColor,
                    child: Text(
                      'Log In',
                      style: themeFont(
                        color: Colors.white,
                        w: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';
import 'package:huddle_and_score/screens/widgets/logo_widget.dart';

import '../../constants.dart';

enum screen { Normal, Pass, Fail }

class PasswordAssistInitialScreen extends StatefulWidget {
  @override
  _PasswordAssistInitialScreenState createState() =>
      _PasswordAssistInitialScreenState();
}

class _PasswordAssistInitialScreenState
    extends State<PasswordAssistInitialScreen> {
  TextEditingController _controller = TextEditingController();

  screen currState = screen.Normal;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    print(currState);
    return CommonScaffold(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: kThemeColor,
                        size: 15.0,
                      ),
                      Text(
                        'Back',
                        style: themeFont(color: kThemeColor, s: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                Row(
                  children: [
                    LogoWidget(),
                    Spacer(),
                  ],
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
                  (currState != screen.Pass)
                      ? 'Enter the Email ID associated with your Huddle & Score account to receive a link.'
                      : 'We have sent a link to the following Email ID to get you back into your account.',
                  style: themeFont(s: 14, w: 'r'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: TextField(
                    controller: _controller,
                    onTap: () {},
                    style: themeFont(
                      color: Colors.black,
                    ),
                    decoration: normalTextDecoration('Email ID'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (currState == screen.Normal)
                    ? Container()
                    : (currState == screen.Pass)
                        ? SizedBox(
                            width: double.infinity,
                            height: 20,
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  ('Didn\'t receive an email? '),
                                  style: themeFont(s: 13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currState = screen.Normal;
                                    });
                                  },
                                  child: Text(
                                    ('Resend'),
                                    style: themeFont(s: 13, w: 'r').copyWith(
                                        color: kThemeColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            width: w * (356 / kScreenW),
                            height: 20,
                            child: Row(
                              children: [
                                Text(
                                  'Please make sure you enter an Email ID',
                                  style: themeFont(
                                      color: Colors.red, s: 12, w: 'r'),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                          ),
                SizedBox(height: h * 0.02),
                (currState == screen.Fail)
                    ? SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Text(
                          'Please make sure you enter an Email ID that is associated with your Huddle & Score account.',
                          style: themeFont(
                            w: 'r',
                            s: 13,
                          ),
                        ),
                      )
                    : Container(),
                (currState == screen.Pass)
                    ? Container()
                    : SizedBox(
                        width: double.infinity,
                        child: ActionButton(
                            bgColor: true ? kThemeColor : Colors.transparent,
                            borderColor:
                                true ? kThemeColor : Colors.transparent,
                            child: Text(
                              'Submit',
                              style: themeFont(
                                s: 16,
                                w: 'm',
                                color: (true)
                                    ? Colors.white
                                    : Colors.grey.withOpacity(0.9),
                              ),
                            ),
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoadingScreen(),
                                ),
                              );
                              AuthRepository()
                                  .sendPasswordResetEmail(
                                      _controller.text.trim())
                                  .then((value) {
                                setState(() {
                                  currState = screen.Pass;
                                });
                              }).onError((error, stackTrace) {
                                setState(() {
                                  currState = screen.Fail;
                                });
                              });
                              Navigator.pop(context);
                            }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

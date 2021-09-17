import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

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
                    'assets/images/huddle_logo.png',
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
                    (currState != screen.Pass)
                        ? 'Enter the Email ID associated with your Huddle & Score account to receive a link.'
                        : 'A link to reset your password has been sent to the following Email ID.',
                    style: themeFont(s: 14),
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
                                    onTap: (){
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
                                    'Invalid Email-id!',
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
                            'Please make sure you enter an email id that is associated with your Huddle & Score account.',
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
                                    .sendPasswordResetEmail(_controller.text)
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
      ),
    );
  }
}

class PasswordAssistSuccessScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  print(state);
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
                    'assets/images/huddle_logo.png',
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
                    style: themeFont(s: 12, w: 'r'),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'A link to reset your password has been sent to the following Email ID. ',
                    style: themeFont(s: 14, w: 'm'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      controller: _controller,
                      style: themeFont(
                        color: Colors.black,
                        w: 'n',
                      ),
                      decoration: normalTextDecoration('Email ID'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          ('Didn\'t receive an email? '),
                          style: themeFont(s: 13),
                        ),
                        Text(
                          ('Resend'),
                          style: themeFont(s: 13, w: 'r').copyWith(
                              color: kThemeColor,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordAssistFailureScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    'assets/images/huddle_logo.png',
                    height: h * 0.1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password Assistance',
                    style: themeFont(w: 'm', color: kThemeColor, s: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Get back into your account with 2 quick steps!',
                    style: themeFont(
                      s: 12,
                      w: 'r',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Enter the Email ID associated with your Huddle & Score account to receive a link.',
                    style: themeFont(s: 14, w: 'm'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      controller: _controller,
                      style: themeFont(
                        color: Colors.black,
                        w: 'n',
                      ),
                      decoration: normalTextDecoration('Email ID'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: w * (356 / kScreenW),
                    height: 20,
                    child: Row(
                      children: [
                        Text(
                          'Invalid Email-id!',
                          style: themeFont(color: Colors.red, s: 12, w: 'r'),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Text(
                      'Please make sure you enter an email id that is associated with your Huddle & Score account.',
                      style: themeFont(
                        w: 'r',
                        s: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.2),
                  SizedBox(
                    width: double.infinity,
                    child: ActionButton(
                      bgColor: kThemeColor,
                      child: Text(
                        'Submit',
                        style: themeFont(
                          color: Colors.white,
                          w: 'n',
                        ),
                      ),
                      onTap: () {},
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../constants.dart';

class PasswordAssistInitialScreen extends StatelessWidget {
  ForgotPasswordBloc _bloc;
  TextEditingController _controller = TextEditingController();
  // 0 - error
  // 1 - default
  // 2 - success
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ForgotPasswordBloc>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        await _bloc.close();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              if (state is ForgotPasswordLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ForgotPasswordSuccessState) {
                return PasswordAssistSuccessScreen();
              } else if (state is ForgotPasswordFailureState) {
                return PasswordAssistFailureScreen();
              }
              return Container(
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
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          builder: (context, state) {
                            return Container(
                              width: w * (356 / kScreenW),
                              child: TextField(
                                controller: _controller,
                                onTap: () {
                                  _bloc.add(onEmailChanged());
                                },
                                style: themeFont(
                                  color: Colors.black,
                                  w: FontWeight.normal,
                                ),
                                decoration: normalTextDecoration(
                                    state.emailTap, 'Email id'),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: w * (356 / kScreenW),
                          height: 20,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 1,
                              ),
                            ],
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
                            _bloc.add(
                              ForgotPasswordInitiated(email: _controller.text),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
                      controller: _controller,
                      style: themeFont(
                        color: Colors.black,
                        w: FontWeight.normal,
                      ),
                      decoration: normalTextDecoration(true, 'Email id'),
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
                        Spacer(),
                        Text(
                          ('Didn\'t receive an email? '),
                          style: themeFont(s: 13),
                        ),
                        Text(
                          ('Resend'),
                          style: themeFont(s: 13).copyWith(
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
                      controller: _controller,
                      style: themeFont(
                        color: Colors.black,
                        w: FontWeight.normal,
                      ),
                      decoration: normalTextDecoration(true, 'Email id'),
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
                          style: themeFont(color: Colors.red, s: 12),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w * (356 / kScreenW),
                    height: 30,
                    child: Text(
                      'Please make sure you enter an email id that is associated with your Huddle & Score account.',
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
                    onTap: () {},
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../../constants.dart';

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
                          'Enter the registered Email id to receive a link',
                          style: themeFont(s: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          builder: (context, state) {
                            bool isOk = state.emailTap;
                            return Container(
                              width: double.infinity,
                              child: TextField(
                                controller: _controller,
                                onTap: () {
                                  _bloc.add(onEmailChanged());
                                },
                                style: themeFont(
                                  color: Colors.black,
                                ),
                                decoration: normalTextDecoration('Email id'),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
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
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          builder: (context, state) {
                            return SizedBox(
                              width:double.infinity,

                              child: ActionButton(
                                bgColor: state.emailTap
                                    ? kThemeColor
                                    : Colors.transparent,
                                borderColor: state.emailTap
                                    ? kThemeColor
                                    : Colors.transparent,
                                child: Text(
                                  'Submit',
                                  style: themeFont(
                                    s: 16,
                                    w: 'm',
                                    color: (state.emailTap)
                                        ? Colors.white
                                        : Colors.grey.withOpacity(0.9),
                                  ),
                                ),
                                onTap: (state.emailTap)
                                    ? () {
                                        _bloc.add(
                                          ForgotPasswordInitiated(
                                              email: _controller.text),
                                        );
                                      }
                                    : () {
                                        print("Fill Everything");
                                      },
                              ),
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
                    'A link to reset your password has been sent to the following email id. ',
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
                      decoration: normalTextDecoration('Email id'),
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
                    'Enter the registered Email id to receive a link',
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
                      decoration: normalTextDecoration('Email id'),
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
                    width:double.infinity,

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

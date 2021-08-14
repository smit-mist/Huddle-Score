import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huddle_and_score/blocs/signup/signup_bloc.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../../constants.dart';

class SignUpScreen extends StatelessWidget {
  SignupBloc _signupBloc;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocListener<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        Navigator.pushNamed(context, 'home');
                      }
                    },
                    child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        if (state is SignUpLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SignUpFailure) {
                          return _onFailure();
                        } else if (state is SignUpSuccess) {
                          emailCtrl.text = '';
                          nameCtrl.text = '';
                          passwordCtrl.text = '';
                          return Container();
                        }
                        return Container();
                      },
                    ),
                  ),
                  Image.asset(
                    'assets/images/huddle_logo.jpeg',
                    height: h * 0.1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create a new account',
                    style: themeFont(
                      color: kThemeColor,
                      s: 20,
                      w: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return Container(
                        // name
                        width: w * (356 / kScreenW),
                        child: TextField(
                          controller: nameCtrl,
                          onTap: () {
                            _signupBloc.add(NameOnTap());
                          },
                          style: themeFont(
                            color: Colors.black,
                            w: FontWeight.normal,
                          ),
                          decoration: normalTextDecoration(
                              'Full Name'),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return Container(
                        // email
                        width: w * (356 / kScreenW),
                        child: TextField(
                          controller: emailCtrl,
                          onTap: () {
                            _signupBloc.add(EmailOnTap());
                          },
                          style: themeFont(
                            color: Colors.black,
                            w: FontWeight.normal,
                          ),
                          decoration: normalTextDecoration(
                             'Email id'),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return Container(
                        // password
                        width: w * (356 / kScreenW),
                        child: TextField(
                          controller: passwordCtrl,
                          onTap: () {
                            _signupBloc.add(PasswordOnTap());
                          },
                          style: themeFont(
                            color: Colors.black,
                            w: FontWeight.normal,
                          ),
                          obscureText: state.obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: themeFont(
                                color: Color(0xff626262),
                                w: FontWeight.normal,
                                s: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                state.obscureText = !state.obscureText;
                              },
                              child: Icon(
                                (state.obscureText == false
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: (state.passwordTapped == true)
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
                              borderSide: (state.passwordTapped == false
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
                              borderSide: (state.passwordTapped == false
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
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return Container(
                        // confirm pass
                        width: w * (356 / kScreenW),
                        child: TextField(
                          onTap: () {
                            _signupBloc.add(ConfirmPasswordOnTap());
                          },
                          style: themeFont(
                            color: Colors.black,
                            w: FontWeight.normal,
                          ),
                          obscureText: state.obscureText,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: themeFont(
                                color: Color(0xff626262),
                                w: FontWeight.normal,
                                s: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                state.obscureText = !state.obscureText;
                              },
                              child: Icon(
                                (state.obscureText == false
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: (state.confirmPasswordTapped == true)
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
                              borderSide: (state.confirmPasswordTapped == false
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
                              borderSide: (state.confirmPasswordTapped == false
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
                      );
                    },
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
                  Container(
                    width: w * (356 / kScreenW),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: kThemeColor,
                            child: SvgPicture.asset(
                              'assets/icons/checkbox.svg',
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: w * (330 / kScreenW),
                          child: Wrap(
                            children: [
                              Text(
                                "By creating an account, I agree to Huddle & Score's ",
                                style: themeFont(
                                  s: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Conditions of Use',
                                  style: themeFont(
                                    s: 12.0,
                                    color: Colors.blue,
                                  ).copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Text(
                                ' and ',
                                style: themeFont(
                                  s: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Privacy Policy',
                                  style: themeFont(
                                    s: 12.0,
                                    color: Colors.blue,
                                  ).copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActionButton(
                      bgColor: kThemeColor,
                      child: Text(
                        'Sign Up',
                        style: themeFont(
                          color: Colors.white,
                          w: FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        _signupBloc.add(
                          SignUpButtonPressed(
                            email: emailCtrl.text,
                            password: passwordCtrl.text,
                            name: nameCtrl.text,
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: themeFont(s: 13)),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'sign_in');
                        },
                        child: Text(
                          'Log in',
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

Widget _onFailure() {}
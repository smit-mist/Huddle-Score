import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/blocs/login/login_bloc.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../../constants.dart';

class SignInScreen extends StatelessWidget {
  LoginBloc _loginBloc;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushNamed(
                          context,
                          'home',
                        );
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoginFailure) {
                          return _onFailure();
                        } else if (state is LoginSuccess) {
                          emailCtrl.text = '';
                          passwordCtrl.text = '';
                          return Container();
                        }
                        return Container();
                      },
                    ),
                  ),
                  Image.asset(
                    'assets/images/huddle_logo.png',
                    height: h * 0.2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Huddle & Score',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Container(
                        width: double.infinity,

                        child: TextField(
                          onTap: () {
                            _loginBloc.add(EmailFieldPressed());
                          },
                          controller: emailCtrl,
                          style: themeFont(
                            color: Colors.black,
                            w: 'r',
                          ),
                          decoration: normalTextDecoration(
                            'Email id',
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (prev, curr) {
                 //     print("Should rebuild because $prev to $curr");
                      return true;
                    },
                    builder: (context, state) {
              //        print(state);
               //       print("Rebuild");

                      return Container(
                        width: double.infinity,

                        child: TextField(
                          onTap: () {
                            _loginBloc.add(PasswordFieldPressed());
                          },
                          controller: passwordCtrl,
                          style: themeFont(
                            color: Colors.black,
                            w: 'r',
                          ),
                          obscureText: state.obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: themeFont(
                                color: Color(0xff626262),
                                w: 'r',
                                s: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                  //              print("OBSCURE PRESSED");
                                _loginBloc.add(ObscureTextPressed());
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
                            fillColor: Colors.transparent,
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
                      );
                    },
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
                          onTap: () {
                            Navigator.pushNamed(context, 'password_assist');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: themeFont(
                                color: kThemeColor,
                                w: 'n',
                                s: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ActionButton(
                      bgColor: kThemeColor,
                      child: Text(
                        'Log In',
                        style: themeFont(
                          color: Colors.white,
                          w: 'm',s: 16
                        ),
                      ),
                      onTap: () {
                        _loginBloc.add(
                          LoginButtonPressed(
                            email: emailCtrl.text,
                            password: passwordCtrl.text,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New to Huddle & Score?', style: themeFont(s: 12,w: 'm')),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'sign_up');
                        },
                        child: Text(
                          'Sign up',
                          style: themeFont(
                            s: 12,w: 'm',
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

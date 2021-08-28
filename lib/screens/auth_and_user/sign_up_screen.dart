import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/blocs/signup/signup_bloc.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class SignUpScreen extends StatelessWidget {
  SignupBloc _signupBloc;
  final _key = GlobalKey<FormState>();
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
            child: BlocConsumer<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeNavBar(),
                    ),
                    (route) => false,
                  );
                } else if (state is SignUpLoading) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoadingScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is SignUpFailure) {
                  return _onFailure();
                } else if (state is SignUpSuccess) {
                  emailCtrl.text = '';
                  nameCtrl.text = '';
                  passwordCtrl.text = '';
                  return Container();
                }
                return SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/huddle_logo.png',
                              height: h * 0.1,
                            ),
                            SizedBox(
                              width: 15,
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Create a new account',
                          style: themeFont(
                            color: kThemeColor,
                            s: 20,
                            w: 'm',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            return Container(
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value == null)
                                    return 'Please Enter your name';
                                  return null;
                                },
                                controller: nameCtrl,
                                onTap: () {
                                  _signupBloc.add(NameOnTap());
                                },
                                style: themeFont(
                                  color: Colors.black,
                                  w: 'n',
                                ),
                                decoration: normalTextDecoration('Full Name'),
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
                              width: double.infinity,

                              child: TextFormField(
                                validator: (value) {
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value))
                                    return 'Please enter a valid email';
                                  return null;
                                },
                                controller: emailCtrl,
                                onTap: () {
                                  _signupBloc.add(EmailOnTap());
                                },
                                style: themeFont(
                                  color: Colors.black,
                                  w: 'n',
                                ),
                                decoration: normalTextDecoration('Email id'),
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
                              width: double.infinity,

                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      value.length < 8)
                                    return 'Please Enter the password in the given mannner';
                                  return null;
                                },
                                controller: passwordCtrl,
                                onTap: () {
                                  _signupBloc.add(PasswordOnTap());
                                },
                                style: themeFont(
                                  color: Colors.black,
                                  w: 'n',
                                ),
                                obscureText: state.obscureText,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: themeFont(
                                      color: Color(0xff626262), w: 'n', s: 14),
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
                                  fillColor: Colors.grey.withOpacity(0),
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
                          height: 10,
                        ),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            return Container(
                              // confirm pass
                              width: double.infinity,

                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value != passwordCtrl.text ||
                                      value == null)
                                    return 'Passwords don\'t match';
                                  return null;
                                },
                                onTap: () {
                                  _signupBloc.add(ConfirmPasswordOnTap());
                                },
                                style: themeFont(
                                  color: Colors.black,
                                  w: 'n',
                                ),
                                obscureText: state.obscureText,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: themeFont(
                                      color: Color(0xff626262), w: 'n', s: 14),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      state.obscureText = !state.obscureText;
                                    },
                                    child: Icon(
                                      (state.obscureText == false
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      color:
                                          (state.confirmPasswordTapped == true)
                                              ? kThemeColor
                                              : Colors.grey.withOpacity(0.4),
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0),
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
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Password should be at least 6 characters long and must include at least 1 number. Ex. @,\$,%,!.',
                            style: themeFont(
                              color: Colors.black,
                              s: 10,
                              w: 'r',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
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
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: themeFont(),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            "By creating an account, I agree to Huddle & Score's ",
                                        style: themeFont(
                                          s: 12.0,
                                          w: 'r',
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Conditions of Use',
                                        style: themeFont(
                                          s: 12.0,
                                          w: 'r',
                                          color: Colors.blue,
                                        ).copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      TextSpan(
                                        text: ' and ',
                                        style: themeFont(
                                          s: 12.0,
                                          w: 'r',
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: themeFont(
                                          s: 12.0,
                                          w: 'r',
                                          color: Colors.blue,
                                        ).copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  // children: [

                                  // ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            bool isOk = (state.emailTapped &
                                state.passwordTapped &
                                state.confirmPasswordTapped &
                                state.nameTapped);
                            print(isOk);
                            return SizedBox(
                              width: double.infinity,
                              child: ActionButton(
                                  bgColor:
                                      (isOk) ? kThemeColor : Colors.transparent,
                                  borderColor:
                                      (isOk) ? kThemeColor : Colors.transparent,
                                  child: Text(
                                    'Sign Up',
                                    style: themeFont(
                                      color: (isOk)
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.9),
                                      w: 'n',
                                    ),
                                  ),
                                  onTap: (isOk)
                                      ? () {
                                          if (_key.currentState.validate()) {
                                            _signupBloc.add(
                                              SignUpButtonPressed(
                                                email: emailCtrl.text,
                                                password: passwordCtrl.text,
                                                name: nameCtrl.text,
                                              ),
                                            );
                                          }
                                        }
                                      : () {
                                          print("Fill Everything");
                                        }),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: themeFont(
                                  s: 12,
                                  w: 'm',
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, 'sign_in');
                              },
                              child: Text(
                                'Log in',
                                style: themeFont(
                                  s: 12,
                                  w: 'm',
                                  color: kThemeColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _onFailure() {}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/blocs/login/login_bloc.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginBloc _loginBloc;
  final _key = GlobalKey<FormState>();
  bool visible = false;
  bool emailTapped = false;
  bool isFailed = false;
  bool passTapped = false;
  TextEditingController emailCtrl = TextEditingController();

  TextEditingController passwordCtrl = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

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
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeNavBar(),
                    ),
                    (route) => false,
                  );
                } else if (state is LoginLoading) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoadingScreen(),
                    ),
                  );
                } else if (state is LoginFailure) {
                  print("Error in main builder");

                  Navigator.pop(context);
                  setState(() {
                    isFailed = true;
                  });
                }
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
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
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value))
                              return 'Please enter a valid email';
                            return null;
                          },
                          onChanged: (ok) {
                            setState(() {
                              if (ok.length > 0) emailTapped = true;
                              if (ok.length == 0) emailTapped = false;
                            });
                          },
                          controller: emailCtrl,
                          style: themeFont(
                            color: Colors.black,
                            w: 'r',
                          ),
                          decoration:
                              textFieldDecoration('Email ID', emailTapped),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) {
                            // if (isFailed) return null;
                            if (value.isEmpty || value == null)
                              return 'Please enter your password';
                            return null;
                          },
                          onChanged: (ok) {
                            setState(() {
                              if (ok.length > 0)
                                passTapped = true;
                              else
                                passTapped = false;
                            });
                          },
                          controller: passwordCtrl,
                          style: themeFont(
                            color: Colors.black,
                            w: 'r',
                          ),
                          obscureText: !visible,
                          decoration: InputDecoration(
                            errorText: (isFailed) ? 'Invalid pass' : null,
                            hintText: 'Password',
                            hintStyle: themeFont(
                                color: Color(0xff626262), w: 'r', s: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  //   passTapped = true;
                                  visible = !visible;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),

                             //   color: kThemeColor,
                                child: SvgPicture.asset(
                                  'assets/icons/password_eye_open.svg',
                                  color: passTapped == true?kThemeColor:Colors.grey.withOpacity(0.7),
                                ),

                                // child: Icon(
                                //   (visible == true
                                //       ? Icons.visibility
                                //       : Icons.visibility_off),
                                //   color: (passTapped == true)
                                //       ? kThemeColor
                                //       : Colors.grey.withOpacity(0.4),
                                // ),
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                            filled: true,
                            fillColor: Colors.transparent,
                            focusedErrorBorder: (passTapped == false)
                                ? OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: kThemeColor,
                                    ),
                                  ),
                            errorBorder: (passTapped == false)
                                ? OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: kThemeColor,
                                    ),
                                  ),
                            enabledBorder: (passTapped == false)
                                ? OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: kThemeColor,
                                    ),
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
                                    color: kThemeColor, w: 'n', s: 11),
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
                            style:
                                themeFont(color: Colors.white, w: 'm', s: 16),
                          ),
                          onTap: () {
                            if (_key.currentState.validate()) {
                              _loginBloc.add(
                                LoginButtonPressed(
                                  email: emailCtrl.text,
                                  password: passwordCtrl.text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New to Huddle & Score?',
                              style: themeFont(s: 12, w: 'm')),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'sign_up');
                            },
                            child: Text(
                              'Sign Up',
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

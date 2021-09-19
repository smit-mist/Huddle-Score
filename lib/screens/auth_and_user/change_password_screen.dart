import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/repositories/user_repository.dart';
import 'package:huddle_and_score/screens/auth_and_user/password_assist_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String errorText = '';
  final key = GlobalKey<FormState>();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController pass3 = TextEditingController();
  bool visible1 = false, visible2 = false, visible3 = false;
  bool passTapped1 = false, passTapped2 = false, passTapped3 = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Change Password',
                        style: themeFont(color: kThemeColor, s: 23),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Current Password',
                    style: themeFont(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: pass1,
                    style: themeFont(
                      color: Colors.black,
                    ),
                    obscureText: !visible1,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF1F1F1),
                      hintText: 'Password',
                      hintStyle:
                          themeFont(color: Color(0xff626262), w: 'r', s: 14),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            //   passTapped = true;
                            visible1 = !visible1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),

                          //   color: kThemeColor,
                          //    child: SvgPicture.asset(
                          //      'assets/icons/password_eye_open.svg',
                          //      color: passTapped == true?kThemeColor:Colors.grey.withOpacity(0.7),
                          //    ),

                          child: Icon(
                            (visible1 == true
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: (passTapped1 == true)
                                ? kThemeColor
                                : Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                      errorText: errorText,
                      contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                      filled: true,
                      focusedErrorBorder: (passTapped1 == false)
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
                      errorBorder: (passTapped1 == false)
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
                      enabledBorder: (passTapped1 == false)
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
                    onChanged: (x) {
                      setState(() {
                        if (x.length > 0)
                          passTapped1 = true;
                        else
                          passTapped1 = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                          child: Text(
                            'Forgot Password?',
                            style: themeFont(s: 12),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PasswordAssistInitialScreen(),
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Password',
                    style: themeFont(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty ||
                          value == null ||
                          value.contains(
                                RegExp(
                                  r'[!@#$%^&*(),.?":{}|<>]',
                                ),
                              ) ==
                              false)
                        return 'Please Enter the password in the given manner';
                      return null;
                    },
                    style: themeFont(
                      color: Colors.black,
                    ),
                    obscureText: !visible2,
                    controller: pass2,
                    onChanged: (x) {
                      setState(() {
                        if (x.length > 0)
                          passTapped2 = true;
                        else
                          passTapped2 = false;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF1F1F1),
                      hintText: 'Create New Password',
                      hintStyle:
                          themeFont(color: Color(0xff626262), w: 'r', s: 14),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            //   passTapped = true;
                            visible2 = !visible2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),

                          //   color: kThemeColor,
                          //    child: SvgPicture.asset(
                          //      'assets/icons/password_eye_open.svg',
                          //      color: passTapped == true?kThemeColor:Colors.grey.withOpacity(0.7),
                          //    ),

                          child: Icon(
                            (visible2 == true
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: (passTapped2 == true)
                                ? kThemeColor
                                : Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                      filled: true,
                      focusedErrorBorder: (passTapped2 == false)
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
                      errorBorder: (passTapped2 == false)
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
                      enabledBorder: (passTapped2 == false)
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
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: w * (356 / kScreenW),
                    child: Text(
                      'Password should be at least 6 characters long and must include a minimum of 1 number',
                      style: themeFont(
                        color: Colors.black,
                        s: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Confirm New Password',
                    style: themeFont(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != pass2.text) return 'Passwords don\'t match';
                      return null;
                    },
                    controller: pass3,
                    style: themeFont(
                      color: Colors.black,
                    ),
                    onChanged: (x) {
                      setState(() {
                        if (x.length > 0)
                          passTapped3 = true;
                        else
                          passTapped3 = false;
                      });
                    },
                    obscureText: !visible3,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF1F1F1),
                      hintText: 'Re-enter New Password',
                      hintStyle:
                          themeFont(color: Color(0xff626262), w: 'r', s: 14),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            //   passTapped = true;
                            visible3 = !visible3;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),

                          //   color: kThemeColor,
                          //    child: SvgPicture.asset(
                          //      'assets/icons/password_eye_open.svg',
                          //      color: passTapped == true?kThemeColor:Colors.grey.withOpacity(0.7),
                          //    ),

                          child: Icon(
                            (visible3 == true
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: (passTapped3 == true)
                                ? kThemeColor
                                : Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
                      filled: true,
                      focusedErrorBorder: (passTapped3 == false)
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
                      errorBorder: (passTapped3 == false)
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
                      enabledBorder: (passTapped3 == false)
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
                  SizedBox(
                    height: h * 0.07,
                  ),
                  Container(
                    width: double.infinity,
                    height: 42,
                    child: ActionButton(
                      onTap: () async {
                        if (key.currentState.validate()) {
                          setState(() {
                            errorText = '';
                          });
                          print(pass1.text + 'here22');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LoadingScreen()));
                          var credential = EmailAuthProvider.credential(
                            email: FirebaseAuth.instance.currentUser.email,
                            password: pass1.text,
                          );
                          FirebaseAuth.instance.currentUser
                              .reauthenticateWithCredential(credential)
                              .then((value) async {
                            print('reauthenticated');
                            await UserRepository()
                                .changeUserPassword(pass2.text);
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: 'Password Changed');
                          }, onError: (error, stackTrace) {
                            print("Error while reauthenticating");
                            print(error.toString());
                            print(stackTrace.toString());
                            setState(() {
                              errorText = 'Please enter the current password';
                            });
                            Navigator.pop(context);
                            return null;
                          });
                        }
                      },
                      child: Text(
                        'Save Changes',
                        style: themeFont(
                          color: Colors.white,
                        ),
                      ),
                      bgColor: kThemeColor,
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

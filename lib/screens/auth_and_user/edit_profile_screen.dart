import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/user_repository.dart';
import 'package:huddle_and_score/screens/auth_and_user/change_password_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/welcome_screen.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

class EditProfileScreen extends StatefulWidget {

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isVerified = FirebaseAuth.instance.currentUser.emailVerified;
  bool nametap = false;
  Timer _timer;
  HomeNavBarBloc _bloc;
  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        await FirebaseAuth.instance.currentUser
          ..reload();
        var user = FirebaseAuth.instance.currentUser;
        if (user.emailVerified) {
          setState(() {
            isVerified = user.emailVerified;
          });
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = FirebaseAuth.instance.currentUser.displayName;
    String email = FirebaseAuth.instance.currentUser.email;
    TextEditingController _nameCtrl = TextEditingController();
    _bloc = BlocProvider.of<HomeNavBarBloc>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  Text(
                    'Account',
                    style: themeFont(color: kThemeColor, s: 23),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Full Name',
                style: themeFont(),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _nameCtrl,
                onTap: () {
                  setState(() {
                    nametap = true;
                  });
                },
                showCursor: nametap,
                enableInteractiveSelection: false,
                focusNode: FocusNode(),
                decoration: normalTextDecoration(name).copyWith(
                  suffixIcon: Icon(
                    Icons.edit,
                  ),
                ),
              ),
              nametap
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              nametap
                  ? Container(
                      width: w,
                      height: h * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: w * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: kThemeColor,
                                width: 1.0,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  nametap = false;
                                });
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              },
                              child: Text(
                                'Cancel',
                                style: themeFont(
                                  color: kThemeColor,
                                  w: 'r',
                                  s: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: w * 0.4,
                            decoration: BoxDecoration(
                              color: kThemeColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                style: BorderStyle.none,
                                width: 1.0,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                _bloc.add(HomeIconPressed());
                                await UserRepository()
                                    .changeUserName(_nameCtrl.text);
                                _bloc.add(ProfileIconPressed());
                                setState(() {
                                  nametap = false;
                                });
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              },
                              child: Text(
                                'Save',
                                style: themeFont(
                                  color: Colors.white,
                                  w: 'r',
                                  s: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email ID',
                style: themeFont(),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                style: themeFont(
                  color: Colors.redAccent,
                ),
                decoration: normalTextDecoration(email).copyWith(
                    hintStyle: themeFont(
                  color: !isVerified ? Colors.redAccent : Color(0xff626262),
                )),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.currentUser
                          .sendEmailVerification();
                      Fluttertoast.showToast(msg: 'Verification email sent');
                      print("On tap khatam");
                    },
                    child: isVerified
                        ? Container()
                        : RichText(
                            text: TextSpan(
                              style: themeFont(),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Email not verified! ',
                                  style:
                                      themeFont(color: Colors.redAccent, s: 12),
                                ),
                                TextSpan(
                                  text: 'Verify Email',
                                  style: themeFont(color: kThemeColor, s: 12)
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangePasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  'Change Password',
                  style: themeFont()
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoadingScreen(),
                    ),
                  );
                  await AuthRepository().signOut();
                  _bloc.add(HomeIconPressed());
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => WelcomeScreen()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Log Out',
                  style: themeFont()
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

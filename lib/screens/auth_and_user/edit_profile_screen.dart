import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/user_repository.dart';
import 'package:huddle_and_score/screens/auth_and_user/change_password_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/welcome_screen.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../home_navbar_screen.dart';

class EditProfileScreen extends StatelessWidget {
  HomeNavBarBloc _bloc;
  String name, email;
  EditProfileScreen({this.email, this.name});
  @override
  Widget build(BuildContext context) {
    final isVerified = FirebaseAuth.instance.currentUser.emailVerified;
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
                textInputAction: TextInputAction.done,
                onSubmitted: (value) async {
                  _bloc.add(HomeIconPressed());
                  await UserRepository().changeUserName(value);
                  _bloc.add(ProfileIconPressed());
                },
                decoration: normalTextDecoration(name).copyWith(
                  suffixIcon: Icon(
                    Icons.edit,
                  ),
                ),
              ),
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
                  color: Colors.redAccent,
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
                      _bloc.add(HomeIconPressed());
                      print(FirebaseAuth.instance.currentUser.emailVerified);

                      await FirebaseAuth.instance.currentUser
                          .sendEmailVerification();
                      Fluttertoast.showToast(msg: 'Verification email sent');
                      print(FirebaseAuth.instance.currentUser.emailVerified);
                      print("On tap khatam");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeNavBar(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: themeFont(),
                        children: <TextSpan>[
                          TextSpan(
                            text: isVerified
                                ? 'Email Verified'
                                : 'Email not verified! ',
                            style: themeFont(color: Colors.redAccent, s: 12),
                          ),
                          TextSpan(
                            text: 'Verify Email',
                            style: themeFont(color: kThemeColor, s: 12)
                                .copyWith(decoration: TextDecoration.underline),
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

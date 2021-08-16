import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/button_click/button_click_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/blocs/user/user_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/screens/auth_and_user/change_password_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/welcome_screen.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> dispose() async {
      await BlocProvider.of<HomeBloc>(context);
      await BlocProvider.of<UserBloc>(context).close();
      await BlocProvider.of<ButtonClickBloc>(context).close();
    }

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
                decoration: normalTextDecoration('Test User').copyWith(
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
                style: themeFont(
                  color: Colors.redAccent,
                ),
                decoration: normalTextDecoration('test@gmail.com').copyWith(
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
                  RichText(
                    text: TextSpan(
                      style: themeFont(),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Email not verified! ',
                            style: themeFont(color: Colors.redAccent, s: 12)),
                        TextSpan(
                          text: 'Verify Email',
                          style: themeFont(color: kThemeColor, s: 12)
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
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

                  BlocProvider.of<HomeNavBarBloc>(context)
                      .add(HomeIconPressed());
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

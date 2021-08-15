import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/constants.dart';

import 'auth_and_user/anonymous_profile_screen.dart';
import 'auth_and_user/user_profile_screen.dart';
import 'home_screen.dart';

class HomeNavBar extends StatelessWidget {
  Widget showMe;
  HomeNavBar({this.showMe});
  HomeNavBarBloc _homeNavBarBloc;
  @override
  Widget build(BuildContext context) {
    _homeNavBarBloc = BlocProvider.of<HomeNavBarBloc>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeNavBarBloc, HomeNavBarState>(
          builder: (context, state) {
            if (state is UserProfileScreenState) {
              return UserProfileScreen(
                email: state.email,
                name: state.name,
              );
            } else if (state is SearchScreenState) {
              return AnonymousProfileScreen();
            } else if (state is CartScreenState) {
              return HomeScreen();
            } else if (state is AnonymousProfileScreenState) {
              return AnonymousProfileScreen();
            }
            if(showMe != null)return showMe;
            return HomeScreen();
          },
        ),
        bottomNavigationBar: Container(
          width: w,
          height: h * 0.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, -0.5), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //    SizedBox(width: 1,),
              GestureDetector(
                onTap: () {
                  _homeNavBarBloc.add(HomeIconPressed());
                },
                child: Icon(
                  Icons.home,
                  color: kThemeColor,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 1,
              ),

              GestureDetector(
                onTap: () {
                  _homeNavBarBloc.add(SearchIconPressed());
                },
                child: Icon(
                  Icons.search,
                  color: kThemeColor,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 1,
              ),

              GestureDetector(
                onTap: () {
                  _homeNavBarBloc.add(CartIconPressed());
                },
                child: Icon(
                  Icons.shopping_bag,
                  color: kThemeColor,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 1,
              ),

              GestureDetector(
                onTap: () {
                  _homeNavBarBloc.add(ProfileIconPressed());
                },
                child: Icon(
                  Icons.account_circle,
                  color: kThemeColor,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

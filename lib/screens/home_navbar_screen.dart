import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/booking/booking_for_not_login.dart';
import 'package:huddle_and_score/screens/booking/booking_history_screen.dart';
import 'package:huddle_and_score/screens/search_screen.dart';

import 'auth_and_user/anonymous_profile_screen.dart';
import 'auth_and_user/user_profile_screen.dart';
import 'home_screen.dart';
enum screen{Home,Search,Book,Profile}

class HomeNavBar extends StatefulWidget {
  Widget showMe;

  HomeNavBar({this.showMe});

  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  HomeNavBarBloc _homeNavBarBloc;
  screen curr = screen.Home;
  @override
  Widget build(BuildContext context) {
    _homeNavBarBloc = BlocProvider.of<HomeNavBarBloc>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeNavBarBloc, HomeNavBarState>(
          builder: (context, state) {
            if (state is UserProfileScreenState) {
              return UserProfileScreen(
                email: state.email,
                name: state.name,
              );
            } else if (state is SearchScreenState) {
              return SearchScreen();
            } else if (state is CartScreenState) {
      //        print(state.fifaBookings == null);
              return BookingHistoryScreen(
                bookedTours: state.bookings,
                bookedFifa: state.fifaBookings,
              );
            } else if (state is AnonymousProfileScreenState) {
              return AnonymousProfileScreen();
            } else if (state is GuestCartScreenState) {
              return BookingNotSignIn();
            }
            if (widget.showMe != null) return widget.showMe;
            return HomeScreen();
          },
        ),

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
                setState(() {
                  curr = screen.Home;
                });
                _homeNavBarBloc.add(HomeIconPressed());
              },
              child: SvgPicture.asset(
                (curr == screen.Home)? 'assets/icons/Home_Filled.svg':'assets/icons/Homeicon_NotFilled.svg',
                height: 30,
                width: 30,
              ),
              // child: Icon(
              //   Icons.home,
              //   color: kThemeColor,
              //   size: 35,
              // ),
            ),
            SizedBox(
              width: 1,
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  curr = screen.Search;
                });
                _homeNavBarBloc.add(SearchIconPressed());
              },
              child: SvgPicture.asset(
                (curr == screen.Search)? 'assets/icons/Search_NotFilled.svg':'assets/icons/Search_NotFilled.svg',
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(
              width: 1,
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  curr = screen.Book;
                });
                _homeNavBarBloc.add(CartIconPressed());
              },
              child: SvgPicture.asset(
                (curr == screen.Book)? 'assets/icons/Booking_Filled.svg':'assets/icons/Booking_NotFilled.svg',
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(
              width: 1,
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  curr = screen.Profile;
                });
                _homeNavBarBloc.add(ProfileIconPressed());
              },
              child:SvgPicture.asset(
                (curr == screen.Profile)? 'assets/icons/Profile_Filled.svg':'assets/icons/Profile_NotFilled.svg',
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/fifa/view_all_fifa_screen.dart';
import 'package:huddle_and_score/screens/partner_with_us/partner_with_us_intro.dart';
import 'package:huddle_and_score/screens/tournament/view_all_tournament_screen.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

import 'auth_and_user/anonymous_profile_screen.dart';
import 'auth_and_user/user_profile_screen.dart';

class HomeNavBar extends StatelessWidget {
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

class HomeScreen extends StatelessWidget {
  String _chosenValue = "Rajkot";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: Main,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Huddle & Score',
                      style: themeFont(
                        color: kThemeColor,
                        s: 26,
                      ),
                    ),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _chosenValue,
                      style: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: kThemeColor,
                        size: 12,
                      ),
                      underline: Container(),
                      items: <String>[
                        'Ahmd',
                        'Surat',
                        'Rajkot',
                        'Mumbai',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "City",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.qr_code_scanner,
                  color: kThemeColor,
                  size: 35,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PartnerWithUsIntro(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Container(
                  width: w * (355 / kScreenW),
                  height: h * (146 / kScreenH),
                  child: Image.network(
                    'https://picsum.photos/300/200',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Popular Tournaments',
                  style: themeFont(
                    s: 18,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewAllTournamentScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: themeFont(s: 13, color: kThemeColor)
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: h * (215 / kScreenH),
              child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      width: 20,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, int index) {
                    return TournamentTile();
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Fifa Tournaments',
                  style: themeFont(
                    s: 18,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewAllFifaScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: themeFont(s: 13, color: kThemeColor)
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: h * (215 / kScreenH),
              child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      width: 20 + (w * (15 / kScreenW)),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (_, int index) {
                    if (index == 0)
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        child: FifaTile(),
                      );
                    return FifaTile();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

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
            if (state is ProfileScreenState) {
              return AnonymousProfileScreen();
            } else if (state is SearchScreenState) {
              return UserProfileScreen();
            } else if (state is CartScreenState) {
              return HomeScreen();
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
            ClipRRect(
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
                Text(
                  'View all',
                  style: themeFont(s: 13, color: kThemeColor)
                      .copyWith(decoration: TextDecoration.underline),
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
                      width: 17,
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
                Text(
                  'View all',
                  style: themeFont(s: 13, color: kThemeColor)
                      .copyWith(decoration: TextDecoration.underline),
                )
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: h * (215 / kScreenH),
              child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      width: 17,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, int index) {
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

class AnonymousProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: h * (63 / kScreenH),
          ),
          Container(
            height: h * (65 / kScreenH),
            width: w * (348 / kScreenW),
            decoration: BoxDecoration(
              color: kThemeColor,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Stack(
              children: [
                Align(
                  child: Text(
                    'Sign In',
                    style: themeFont(
                      s: 18,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: kThemeColor,
                          size: 40,
                        ),
                        height: w * (55 / kScreenW),
                        width: w * (55 / kScreenW),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            height: h * 0.3,
            width: w * 0.9,
            child: ListView(
              children: [
                IgnorePointer(
                  child: ExpansionTile(
                    title: Text(
                      'Account',
                      style: themeFont(color: Colors.grey.withOpacity(0.6)),
                    ),
                    leading: Icon(Icons.exit_to_app_sharp,
                        color: Colors.grey.withOpacity(0.6)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                ),
                Divider(),
                ExpansionTile(
                  title: Text(
                    'Help & Support',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.notifications_none,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
                Divider(),
                ExpansionTile(
                  title: Text(
                    'About',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.add_circle_outline,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
          Spacer(),
          Text(
            'from',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
          ),
          Text(
            'GROWNITED',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  String name;
  String email;
  UserProfileScreen({this.name, this.email});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: h * (63 / kScreenH),
          ),
          Container(
            height: h * (65 / kScreenH),
            width: w * (348 / kScreenW),
            child: Row(
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://picsum.photos/300/200',
                    width: w * (74 / kScreenW),
                    height: h * (56 / kScreenH),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, ${name}',
                      style: themeFont(
                        color: kThemeColor,
                        s: 20,
                      ),
                    ),
                    Text(
                      '${email}',
                      style: themeFont(
                        color: Colors.red,
                        s: 10,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            height: h * 0.3,
            width: w * 0.9,
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Account',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.exit_to_app_sharp,
                  ),
                  trailing: Container(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Help & Support',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.notifications_none,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'About',
                    style: themeFont(),
                  ),
                  leading: Icon(
                    Icons.add_circle_outline,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
          Spacer(),
          Text(
            'from',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
          ),
          Text(
            'GROWNITED',
            style: GoogleFonts.syne(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

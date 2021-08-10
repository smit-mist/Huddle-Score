import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/home_screen.dart';
import 'package:huddle_and_score/screens/profile_screen.dart';

class HomeNavBar extends StatefulWidget {
  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int state = 0;
  List<Widget> pages = [
    HomeScreen(),
    ProfileScreen(
      loggedIn: true,
    ),
    HomeScreen(),
    ProfileScreen(
      loggedIn: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: pages[state],
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
                    state = 0;
                  });
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
                  setState(() {
                    state = 1;
                  });
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
                  setState(() {
                    state = 2;
                  });
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
                  setState(() {
                    state = 3;
                  });
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

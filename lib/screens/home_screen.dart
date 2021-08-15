import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/screens/partner_with_us/partner_with_us_intro.dart';
import 'package:huddle_and_score/screens/tournament/view_all_tournament_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

import '../constants.dart';
import 'fifa/view_all_fifa_screen.dart';

class HomeScreen extends StatelessWidget {
  String _chosenValue = "Rajkot";
  HomeBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: h * (250 / kScreenH),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Failure) {
                    return Center(
                      child: Text('Failed'),
                    );
                  } else if (state is InitialState) {
                    return Container();
                  }
                  return ListView.separated(
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (_, int index) {
                        return TournamentTile(
                            here: state.allTournaments[index]);
                      });
                },
              ),
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
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Failure) {
                    return Center(
                      child: Text('Failed'),
                    );
                  } else if (state is InitialState) {
                    return Container();
                  }
                  return ListView.separated(
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          width: 20 + (w * (15 / kScreenW)),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allFifa.length,
                      itemBuilder: (_, int index) {
                        if (index == 0)
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: FifaTile(fifa: state.allFifa[index]),
                          );
                        return FifaTile(
                          fifa: state.allFifa[index],
                        );
                      });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Turfs Around You',
              style: themeFont(s: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: h * (442 / kScreenH),
              width: w * (354 / kScreenW),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12,
                        ),
                        topRight: Radius.circular(
                          12,
                        ),
                      ),
                      child: Image.network(
                        'https://picsum.photos/id/237/200/300',
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: h * (170 / kScreenH),
                    width: double.infinity,
                  ),
                  Text(
                    'Coming Soon',
                    style: themeFont(color: kThemeColor, s: 23),
                  ),
                  Text(
                    'Be the first one to know when the turfs go live',
                    style: themeFont(),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration:
                          normalTextDecoration('Enter your email address')
                              .copyWith(fillColor: Colors.white),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ActionButton(
                      bgColor: kThemeColor,
                      child: Text(
                        'Subscribe',
                        style: themeFont(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: h * (157 / kScreenH),
              width: w * (354 / kScreenW),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Partner with us!',
                      style: themeFont(s: 18),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              '• ',
                              style: themeFont(color: kThemeColor, s: 17),
                            ),
                            Text(
                              'List Your Tournament',
                              style: themeFont(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              '• ',
                              style: themeFont(color: kThemeColor, s: 17),
                            ),
                            Text(
                              'List Your Turf',
                              style: themeFont(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    //    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ActionButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PartnerWithUsIntro(),
                          ),
                        );
                      },
                      bgColor: kThemeColor,
                      child: Text(
                        'Contact Today!',
                        style: themeFont(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

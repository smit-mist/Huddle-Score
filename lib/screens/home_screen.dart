import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/screens/partner_with_us/partner_with_us_intro.dart';
import 'package:huddle_and_score/screens/tournament/tournament_receipt_screen.dart';
import 'package:huddle_and_score/screens/tournament/view_all_tournament_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';
import 'dart:ui';
import '../constants.dart';
import 'fifa/view_all_fifa_screen.dart';

class HomeScreen extends StatelessWidget {
  String _chosenValue = "Ahmedabad";
  HomeBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int current = 0;
    Widget selectCity = StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: h * (450 / kScreenH),
              width: w * (370 / kScreenW),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Select Your City',
                    style: themeFont(s: 17, w: 'sb'),
                  ),
                  Text(
                    'so we can look for best turfs and tournaments around you',
                    style: themeFont(s: 12, w: 'm'),
                  ),
                  Container(
                    width: w * (350 / kScreenW),
                    height: h * (230 / kScreenH),
                    child: GridView.builder(
                        itemCount: 15,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: (101) / (42),
                        ),
                        itemBuilder: (_, int ind) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (ind == 0) current = ind;
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'City ${ind + 1}',
                                  style: themeFont(s: 12).copyWith(
                                    decoration: ind == 0
                                        ? TextDecoration.none
                                        : TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: (current == ind)
                                        ? kThemeColor
                                        : Colors.transparent),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 42,
                        width: 105,
                        child: ActionButton(
                          child: Text(
                            'Proceed',
                            style:
                                themeFont(color: Colors.white, s: 12, w: 'm'),
                          ),
                          bgColor: kThemeColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return Container(
      width: w,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Huddle & Score',
                      style: themeFont(color: kThemeColor, s: 26, w: 'sb'),
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
                        'Ahmedabad',
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.notifications_none,
                  color: kThemeColor,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext _) => selectCity);
                  },
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: kThemeColor,
                    size: 30,
                  ),
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
                  width: double.infinity,
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
                  style: themeFont(s: 18, w: 'm'),
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
                    style: themeFont(s: 13, color: kThemeColor, w: 'm')
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
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
                  'Online Tournaments',
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
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: h * (225 / kScreenH),
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
                          width: 20,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allFifa.length,
                      itemBuilder: (_, int index) {
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
              style: themeFont(s: 18, w: 'm'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: h * (442 / kScreenH),
              width: double.infinity,
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
                      child: Image.asset(
                        'assets/images/turf_subs.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: h * (170 / kScreenH),
                    width: double.infinity,
                  ),
                  Text(
                    'COMING SOON',
                    style: themeFont(color: kThemeColor, s: 24, w: 'm'),
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
              height: h * (170 / kScreenH),
              width: double.infinity,
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
                  SizedBox(
                    height: 1,
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
                  SizedBox(
                    height: 1,
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

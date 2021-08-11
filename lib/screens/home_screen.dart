import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/view_all_fifa_screen.dart';
import 'package:huddle_and_score/screens/view_all_tournament_screen.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
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
                ),
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
                ),
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
                      width: 20 + (w*(10/kScreenW)),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, int index) {
                    return FifaTile();
                  }),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

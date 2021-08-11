import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

class ViewAllTournamentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: h,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Tournaments in Your City',
                    style: themeFont(
                      color: kThemeColor,
                      s: 23,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: w,
                  //   height:100,
                  child: GridView.builder(
                    itemCount: 10,
                    itemBuilder: (_, ind) {
                      return TournamentTile();
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // width: w * (145 / kScreenW),
                      // height: h * (212 / kScreenH)
                      childAspectRatio:
                          (w * (160 / kScreenW)) / (h * (205 / kScreenH)),
                      crossAxisSpacing: 0.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

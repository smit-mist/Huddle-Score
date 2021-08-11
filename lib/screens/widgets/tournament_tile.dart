import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/tournament/tournament_details.dart';

import '../../constants.dart';

class TournamentTile extends StatefulWidget {
  @override
  _TournamentTileState createState() => _TournamentTileState();
}

class _TournamentTileState extends State<TournamentTile> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TournamentDetails(),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 2.0,
            ),
            child: Container(
              width: w * (145 / kScreenW),
              height: h * (212 / kScreenH),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
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
                        'https://picsum.photos/200/300',
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: h * (112 / kScreenH),
                    width: w * (147 / kScreenW),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: h * (99 / kScreenH),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'FIFA championship 2021',
                          style: themeFont(s: 12),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          'Venus, Ahmedabad',
                          style: themeFont(s: 12),
                        ),
                        Text(
                          '11 -12 March, 2021',
                          style: themeFont(s: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 20,
              width: w * (160 / kScreenW),
              color: Colors.red,
              child: Center(
                child: Text(
                  'Fully Booked!',
                  style: themeFont(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

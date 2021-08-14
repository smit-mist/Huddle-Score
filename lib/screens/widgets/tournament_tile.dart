import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/screens/tournament/tournament_details.dart';

import '../../constants.dart';

class TournamentTile extends StatefulWidget {
  HomeTour here;
  TournamentTile({this.here});
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
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 2.0,
            ),
            child: Container(
              width: w * (155 / kScreenW),
             // height: h * (212 / kScreenH),
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
                        widget.here.photo,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: h * (112 / kScreenH),
                    width: w * (155 / kScreenW),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: h * (120 / kScreenH),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.here.name,
                          style: themeFont(s: 12,w: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          widget.here.venue.join(''),
                          style: themeFont(s: 12),
                        ),
                        Text(
                          widget.here.finalsDate[0],
                          style: themeFont(s: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: h*(100/kScreenH),
            child: Container(
              height: 20,
              width: w * (155 / kScreenW),
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

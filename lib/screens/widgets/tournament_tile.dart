import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/screens/tournament/tournament_details.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class TournamentTile extends StatelessWidget {
  HomeTour here;
  TournamentTile({this.here});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    bool fullFilled = here.room.taken.length == here.room.total;
    double remainingPer =
        (here.room.total - here.room.taken.length * 1.00) / here.room.total;
//    print(here.name + " " +here.room.total.toString()+" " + here.room.taken.length.toString());

    // print(fullFilled);
    //   print(remainingPer);
    WeirdDateFormat st = WeirdDateFormat(date: here.finalsDate[0]),
        en = WeirdDateFormat(date: here.finalsDate[1]);
    String timeLine = "";
    timeLine += st.getDate();
    timeLine += '- ';
    timeLine += en.getDate();
    timeLine += ' ';
    timeLine += st.getMonth();
    timeLine += ', ';
    timeLine += st.getYear();
    String venue = here.venue.join(', ');

    if (here.room.total == here.room.taken.length) fullFilled = true;
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoadingScreen(),
          ),
        );
        Tournament tournament = await Tournament().fromHomeTour(here);
        bool isReg = tournament.registeredIn();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TournamentDetails(
              tournament: tournament,
              isReg: isReg,
            ),
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
              height: h * (250 / kScreenH),
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
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          here.photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: h * (112 / kScreenH),
                      width: w * (155 / kScreenW),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                here.name,
                                style: themeFont(s: 12, w: 'm'),
                              ),
                              Text(
                                venue.length > 35
                                    ? venue.substring(0, 35) + '...'
                                    : venue,
                                style: themeFont(s: 12, w: 'r'),
                              ),
                              Text(
                                timeLine,
                                style: themeFont(s: 12, w: 'r'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          (fullFilled)
              ? Positioned(
                  top: h * (95 / kScreenH),
                  child: Container(
                    // height: h*(40/kScreenH),
                    width: w * (160 / kScreenW),
                    child: Image.asset(
                      'assets/images/fully_booked_banner.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : (remainingPer <= 0.2)
                  ? Positioned(
                      top: h * (95 / kScreenH),
                      child: Container(
                        width: w * (160 / kScreenW),
                        child: Image.asset(
                          'assets/images/filling_fast_banner.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(),
        ],
      ),
    );
  }
}

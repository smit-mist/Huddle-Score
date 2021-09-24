import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/fifa.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/screens/fifa/fifa_details.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class FifaTile extends StatelessWidget {
  HomeFifa fifa;
  FifaTile({this.fifa});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    WeirdDateFormat st = WeirdDateFormat(date: fifa.date);
    String venue = fifa.venue.join(', ');
    bool fullFilled = fifa.room.total == fifa.room.taken.length;
    double remainingPer =
        (1.00 * fifa.room.total - fifa.room.taken.length) / fifa.room.total;
    //  print(fullFilled);
//    print(remainingPer);
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoadingScreen()),
        );
        print('start fetch');
        Fifa here = await Fifa().fromHomeFifa(fifa: fifa);
        print(here == null);
        bool isReg = here.registeredIn();
        //TODO: Unhandled Exception: NoSuchMethodError: The method 'registeredIn' was called on null.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FifaDetails(
              fifa: here,
              isReg: isReg,
            ),
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
              width: w * (155 / kScreenW),
              height: h * (250 / kScreenH),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        fifa.photo,
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
                      padding: EdgeInsets.only(left: 7, right: 7),
                      height: h * (99 / kScreenH),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            fifa.name,
                            style: themeFont(s: 12, w: 'm'),
                          ),
                          Text(
                            venue.length > 45
                                ? venue.substring(0, 45) + '...'
                                : venue,
                            style: themeFont(s: 12, w: 'r'),
                          ),
                          Text(
                            st.printNormal(),
                            style: themeFont(s: 12, w: 'r'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          (fullFilled)
              ? Positioned(
                  top: h * (105 / kScreenH),
                  child: Container(
                    width: w * (160 / kScreenW),
                    child: Image.asset(
                      'assets/images/fully_booked_banner.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : (remainingPer <= 0.2)
                  ? Positioned(
                      top: h * (105 / kScreenH),
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

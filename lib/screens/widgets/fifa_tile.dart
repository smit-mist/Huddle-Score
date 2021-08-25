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
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoadingScreen()),
        );
        print('start fetch');
        Fifa here = await Fifa().fromHomeFifa(fifa: fifa);
        bool isReg =false;// here.registeredIn();
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
        //print('====>>>>${here.fifaId}');
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
              height: h * (225 / kScreenH),
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
                        fifa.photo,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: h * (112 / kScreenH),
                    width: w * (155 / kScreenW),
                  ),
                  Container(
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
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          venue.length > 25?venue.substring(0,25)+'...':venue,
                          style: themeFont(s: 12, w: 'r'),
                        ),
                        Text(
                          st.printNormal(),
                          style: themeFont(s: 12, w: 'r'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     height: 20,
          //     width: w*(160/kScreenW),
          //     color: Colors.red,
          //     child: Center(
          //       child: Text(
          //         'Fully Booked!',
          //         style: themeFont(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

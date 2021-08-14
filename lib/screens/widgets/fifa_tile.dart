import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/fifa.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/screens/fifa/fifa_details.dart';

import '../../constants.dart';

class FifaTile extends StatelessWidget {
  HomeFifa fifa;
  FifaTile({this.fifa});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        Fifa here = await Fifa().fromHomeFifa(fifa: fifa);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FifaDetails(
              fifa: here,
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
                        fifa.photo,
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
                          fifa.name,
                          style: themeFont(s: 12),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          fifa.venue.join(' '),
                          style: themeFont(s: 12),
                        ),
                        Text(
                          fifa.date,
                          style: themeFont(s: 12),
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

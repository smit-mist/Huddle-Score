import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';

class BookingNotSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: w,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.04,
          ),
          Row(
            children: [
              Text(
                'My Bookings',
                style: themeFont(color: kThemeColor, s: 23),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: h * 0.1,
          ),
          Icon(
            Icons.shopping_bag,
            color: kThemeColor,
            size: 250,
          ),
          SizedBox(
            height: h * 0.1,
          ),
          SizedBox(
            width: w * 0.4,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: themeFont(),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign In ',
                      style: themeFont(color: kThemeColor, s: 16)),
                  TextSpan(
                    text: 'to view your booking history',
                    style: themeFont(s: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: w * 0.5,
            child: Text(
              'All your turf and tournament bookings will appear here',
              style: themeFont(),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/booking.dart';

import '../../constants.dart';

class BookedEventTile extends StatelessWidget {
  final BookingDetails booking;
  BookedEventTile({this.booking});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.85,
      height: h * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  12,
                ),
                bottomLeft: Radius.circular(
                  12,
                ),
              ),
              child: Image.network(
                booking.data.poster,
                fit: BoxFit.cover,
              ),
            ),
            height: double.infinity,
            width: w * (0.4),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                booking.data.title,
                style: themeFont(),
              ),
              Text(
                booking.data.venue.address.join(' '),
                style: themeFont(),
              ),
              Text(
                '4th August',
                style: themeFont(),
              ),
              Text(
                booking.recordedAt,
                style: themeFont(),
              ),
              Container(
                height: 20,
                width: w * (0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Spacer(),
                    Text(
                      'View Receipt',
                      style: themeFont(color: kThemeColor, s: 12).copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}

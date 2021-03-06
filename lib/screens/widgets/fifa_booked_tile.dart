import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/screens/fifa/fifa_receipt_screen.dart';
import 'package:huddle_and_score/screens/tournament/tournament_receipt_screen.dart';

import '../../constants.dart';

class FifaBookingTile extends StatelessWidget {
  final FifaBookingDetails booking;
  FifaBookingTile({this.booking});
  @override
  Widget build(BuildContext context) {
    String venue = booking.data.venue.address.join(', ');
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
                style: themeFont(s: 13.5, w: 'b'),
              ),
              SizedBox(
                width: w*0.4,
                child: Text(
                  //venue.split(', ').join('\n'),
                  venue.length > 45
                      ? venue.substring(0, 45) + '...'
                      : venue,
                  style: themeFont(s: 12, w: 'r'),
                ),
              ),
              Text(
                booking.data.gameDate,
                style: themeFont(s: 12, w: 'r'),
              ),
              Text(
                '??? ${booking.amount / 100}',
                style: themeFont(s: 12, w: 'sb'),
              ),
              Container(
                height: 20,
                width: w * (0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FifaReceiptScreen(
                              bookingID: booking.bookingId,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'View Receipt',
                        style: themeFont(color: kThemeColor, s: 12).copyWith(
                          decoration: TextDecoration.underline,
                        ),
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

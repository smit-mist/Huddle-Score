import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/screens/widgets/booked_event_tile.dart';

import '../../constants.dart';

class BookingHistoryScreen extends StatelessWidget {
  String selected = "Tournaments";
  final List<BookingDetails> bookedTours;
  BookingHistoryScreen({this.bookedTours});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: w,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Bookings',
            style: themeFont(color: kThemeColor, s: 23),
          ),
          DropdownButton<String>(
            focusColor: Colors.grey.withOpacity(0.14),
            value: selected,
            style: TextStyle(color: Colors.white),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: kThemeColor,
              size: 20,
            ),
            underline: Container(),
            items: <String>[
              'Tournaments',
              'Fifa',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (s) {},
            hint: Text(
              "Tournaments",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          (bookedTours == null)
              ? Center(child: Text('No bookings'))
              : Expanded(
                  child: Container(
                    width: w,
                    child: ListView.separated(
                      separatorBuilder: (_, i) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (_, ind) {
                        return BookedEventTile(
                          booking: bookedTours[ind],
                        );
                      },
                      itemCount: bookedTours.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

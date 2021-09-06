import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/screens/widgets/booked_event_tile.dart';

import '../../constants.dart';

class BookingHistoryScreen extends StatefulWidget {
  final List<BookingDetails> bookedTours;
  final List<FifaBookingDetails> bookedFifa;
  BookingHistoryScreen({this.bookedTours, this.bookedFifa});

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  String selected = "Tournaments";

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
            onChanged: (s) {
              setState(() {
                selected = s;
              });
            },
            hint: Text(
              "Tournaments",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          (selected=='Fifa') ?
          (widget.bookedFifa == null)
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
                        return FifaBookingTile(
                          booking: widget.bookedFifa[ind],
                        );
                      },
                      itemCount: widget.bookedFifa.length,
                    ),
                  ),
                ): (widget.bookedTours== null)
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
                              booking: widget.bookedTours[ind],
                            );
                          },
                          itemCount: widget.bookedTours.length,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

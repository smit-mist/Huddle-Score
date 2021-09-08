import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/screens/widgets/booked_event_tile.dart';
import 'package:huddle_and_score/screens/widgets/fifa_booked_tile.dart';

import '../../constants.dart';

class BookingHistoryScreen extends StatefulWidget {
  final List<BookingDetails> bookedTours;
  final List<FifaBookingDetails> bookedFifa;
  BookingHistoryScreen({this.bookedTours, this.bookedFifa});

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  String selected = "Fifa";

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: w,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Text(
              'My Bookings',
              style: themeFont(color: kThemeColor, s: 23),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selected,
                style: themeFont(color: kThemeColor),
                icon: Padding(
                  padding: const EdgeInsets.only(left:5.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: kThemeColor,
                    size: 25,
                  ),
                ),
                underline: Container(),
                items: <String>[
                  'Fifa',
                  'Tournaments',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: themeFont(color: kThemeColor),
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
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(
                'Recent',
                style: themeFont(
                  s: 16.0,
                  w: 'r',
                ),
              ),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 5.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            (selected == 'Fifa')
                ? (widget.bookedFifa == null)
                    ? Center(child: Text('No bookings'))
                    : Container(
                        width: w,
                        height: h * 0.4,
                        child: ListView.separated(
                          separatorBuilder: (_, i) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (_, ind) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: FifaBookingTile(
                                booking: widget.bookedFifa[ind],
                              ),
                            );
                          },
                          itemCount: widget.bookedFifa.length,
                        ),
                      )
                : (widget.bookedTours == null)
                    ? Center(child: Text('No bookings'))
                    : Container(
                        height: h * 0.4,
                        width: w,
                        child: ListView.separated(
                          separatorBuilder: (_, i) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (_, ind) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom:5.0),
                              child: BookedEventTile(
                                booking: widget.bookedTours[ind],
                              ),
                            );
                          },
                          itemCount: widget.bookedTours.length,
                        ),
                      ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                'Earlier this month',
                style: themeFont(
                  s: 16.0,
                  w: 'r',
                ),
              ),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 5.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'No Bookings',
              style: themeFont(
                color: Colors.red,
                s: 18.0,
                w: 'sb',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

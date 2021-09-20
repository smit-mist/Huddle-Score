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
  List<BookingDetails>upTour = [],downTour = [];
  List<FifaBookingDetails>upFifa = [],downFifa = [];
  String selected = "Tournaments";
  @override
  void initState() {
    // TODO: implement initState
    DateTime today = DateTime.now();

    if(widget.bookedTours != null){
      for(int i=0;i<widget.bookedTours.length;i++){
        bool notDone = true;
        for(int j=0;j<widget.bookedTours[i].data.timeLine.length;j++){
          var given = DateTime.parse(widget.bookedTours[i].data.timeLine[j].toString());
          if (today.isAfter(given)) {
            notDone = false;
            break;
          }
        }
        if(notDone){
          print("upcoming ${widget.bookedTours[i].data.title}");
          upTour.add(widget.bookedTours[i]);
        }
        else{
          print("gone ${widget.bookedTours[i].data.title}");

          downTour.add(widget.bookedTours[i]);
        }

      }
    }
    if(widget.bookedFifa != null){
      for(var x in widget.bookedFifa){
        DateTime here = DateTime.parse(x.data.gameDate);
        if(today.isAfter(here)){
          downFifa.add(x);
        }
        else
          upFifa.add(x);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    //  print(widget.bookedTours.length);
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
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: kThemeColor,
                    size: 25,
                  ),
                ),
                underline: Container(),
                items: <String>[
                  'Online Tournaments',
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
                'Upcoming',
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
            (selected != 'Tournaments')
                ? (upFifa == null||upFifa.length ==0)
                    ? Center(child: Text('No bookings'))
                    : Container(
                        width: w,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, i) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (_, ind) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: FifaBookingTile(
                                booking: upFifa[ind],
                              ),
                            );
                          },
                          itemCount: upFifa.length,
                        ),
                      )
                : (upTour == null||upTour.length ==0)
                    ? Center(child: Text('No bookings'))
                    : Container(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, i) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (_, ind) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: BookedEventTile(
                                booking: upTour[ind],
                              ),
                            );
                          },
                          itemCount: upTour.length,
                        ),
                      ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                'Past',
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
            (selected != 'Tournaments')
                ? (downFifa == null||downFifa.length ==0)
                ? Center(child: Text('No bookings'))
                : Container(
              width: w,
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (_, i) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (_, ind) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: FifaBookingTile(
                      booking: downFifa[ind],
                    ),
                  );
                },
                itemCount: downFifa.length,
              ),
            )
                : (downTour == null||downTour.length ==0)
                ? Center(child: Text('No bookings'))
                : Container(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (_, i) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (_, ind) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: BookedEventTile(
                      booking: downTour[ind],
                    ),
                  );
                },
                itemCount: downTour.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

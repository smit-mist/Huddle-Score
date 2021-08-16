import 'package:flutter/material.dart';

import '../../constants.dart';

class Event {
  String title, venue, date, time, poster;
  Event({this.venue, this.date, this.title, this.time, this.poster});
}

class BookedEventTile extends StatelessWidget {
  Event currentEvent = Event(
      venue: 'Maninagar, Ahmedabad',
      poster: 'https://picsum.photos/200/300',
      title: 'Kankaria Complex',
      date: '12/04/2021',
      time: '4:30 - 5:30 pm');
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
                currentEvent.poster,
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
                currentEvent.title,
                style: themeFont(),
              ),
              Text(
                currentEvent.venue,
                style: themeFont(),
              ),
              Text(
                currentEvent.date,
                style: themeFont(),
              ),
              Text(
                currentEvent.time,
                style: themeFont(),
              ),
              Container(
                height: 20,
                width: w*(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   // Spacer(),
                    Text(
                      'View Receipt',
                      style: themeFont(
                        color: kThemeColor,s: 12
                      ).copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1,),
            ],
          )
        ],
      ),
    );
  }
}

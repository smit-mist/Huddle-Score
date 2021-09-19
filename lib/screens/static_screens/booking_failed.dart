import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';

class BookingFailed extends StatefulWidget {
  @override
  _BookingFailedState createState() => _BookingFailedState();
}

class _BookingFailedState extends State<BookingFailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Booking Failed!!. Something Went Wrong.',
                style: themeFont(),
              ),
              SizedBox(height:11,),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomeNavBar()),
                      (route) => false);
                },
                child: Text(
                  'Go to Home',
                  style: themeFont(color: kThemeColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

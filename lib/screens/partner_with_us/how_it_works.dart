import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/partner_with_us/fill_your_details_tournament.dart';
import 'package:huddle_and_score/screens/widgets/bottom_bar_widget.dart';

import '../../constants.dart';
import 'fill_your_details_turf.dart';

class HowItWorks extends StatelessWidget {
  bool isFirst;
  HowItWorks({this.isFirst});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    print("Builded");
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomBar(
          actionName: 'Continue',
          onPressed: () {
            Navigator.push(
              context,
              (isFirst)
                  ? MaterialPageRoute(
                      builder: (_) => FillYourDetailsTurf(),
                    )
                  : MaterialPageRoute(
                      builder: (_) => FillYourDetailsTournament(),
                    ),
            );
          },
          onBack: () {
            Navigator.pop(context);
          },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.05,
              ),
              Text(
                'How it works',
                style: themeFont(
                  s: 23,
                  color: kThemeColor,
                  w: 'sb',
                ),
              ),
              SizedBox(
                height: h * 0.035,
              ),
              showText(
                  'Listing your tournament has never been easier. In just 2 quick steps, set yourself up for endless opportunities!'),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                children: [
                  Icon(
                    Icons.text_snippet,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fill the Form',
                        style: themeFont(s: 18, w: 'm'),
                      ),
                      Text(
                        'Share your details with us',
                        style: themeFont(s: 14, w: 'r'),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone_forwarded,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'We will connect with you shortly',
                        style: themeFont(s: 18, w: 'm'),
                      ),
                      Text(
                        'Our team will contact you in no time!',
                        style: themeFont(s: 14, w: 'r'),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                height: h * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget showText(String text) {
  return SizedBox(
    width: double.infinity,
    child: Text(
      text,
      style: themeFont(s: 18, w: 'r'),
    ),
  );
}

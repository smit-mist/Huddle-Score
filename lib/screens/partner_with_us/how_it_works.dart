import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/partner_with_us/fill_your_details.dart';

import '../../constants.dart';

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: h * 0.08,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1)
          ]),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  style: themeFont(),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FillYourDetails(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.3,
                  child: Center(
                    child: Text(
                      'List Now',
                      style: themeFont(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kThemeColor,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'How it works',
                style: themeFont(
                  s: 23,
                  color: kThemeColor,
                ),
              ),
              showText(
                  'Listing your tournament has never been easier. In just 2 short steps, set yourself up for endless opportunities.'),
              ListTile(
                title: Text(
                  'Fill the Form',
                  style: themeFont(
                    s: 18,
                  ),
                ),
                subtitle: Text(
                  'Share your contact details with us',
                  style: themeFont(s: 14),
                ),
                leading: Icon(
                  Icons.text_snippet,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text(
                  'We\'ll connect with you shortly',
                  style: themeFont(
                    s: 18,
                  ),
                ),
                subtitle: Text(
                  'Our team will contact you in no time!',
                  style: themeFont(s: 14),
                ),
                leading: Icon(
                  Icons.phone_forwarded,
                  size: 40,
                  color: Colors.black,
                ),
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
      style: themeFont(s: 18),
    ),
  );
}

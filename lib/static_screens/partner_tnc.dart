import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/partner_with_us/how_it_works.dart';

TextStyle smallText = themeFont(s: 12, w: 'r');
TextStyle bigText = themeFont(s: 16, w: 'sb');
//TODO: Update the whole terms and conditions.
class PartnerTnC extends StatefulWidget {
  @override
  _PartnerTnCState createState() => _PartnerTnCState();
}

class _PartnerTnCState extends State<PartnerTnC> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
                  print("Pressed");

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HowItWorks(
                        isFirst: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.35,
                  child: Center(
                    child: Text(
                      'Accept',
                      style: themeFont(color: Colors.white, s: 15, w: 'sb'),
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                'Terms of Service for Organisers',
                style: bigText,
              ),
              SizedBox(height: 5,),
              Text(
                '''Your use of the Company’s portal or application of the product Huddle & Score (the Service) is subject to terms and legal agreement between You and the Company. The Company or Huddle & Score herein shall mean “Grownite Private Limited”. Your agreement with the Company will always include, at a minimum, the terms and conditions set out in this document except and otherwise agreed in writing separately.''',
                style: smallText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

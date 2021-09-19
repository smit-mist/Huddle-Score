import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/partner_with_us/how_it_works.dart';

import '../../constants.dart';

TextStyle smallText = themeFont(s: 12, w: 'r');
TextStyle bigText = themeFont(s: 16, w: 'sb');
class UserPrivacyPolicy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                'User Privacy Policy',
                style: bigText,
              ),
              SizedBox(height: 5,),
              Text(
                'Your use of the Company’s portal or application of the product Huddle & Score (the Service) is subject to terms and legal agreement between You and the Company. The Company or Huddle & Score herein shall mean “Grownite Private Limited”. Your agreement with the Company will always include, at a minimum, the terms and conditions set out in this document except and otherwise agreed in writing separately.',
                style: smallText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';

import '../../constants.dart';

class UserTermsAndConditions extends StatefulWidget {
  @override
  _UserTermsAndConditionsState createState() => _UserTermsAndConditionsState();
}

class _UserTermsAndConditionsState extends State<UserTermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          height: h * 0.95,
          width: w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'USER TERMS AND CONDITIONS- Huddle & Score',
                  style: themeFont(),
                ),
                Text(
                  'As updated on (Launching Date)',
                  style: themeFont(),
                ),
                RichText(
                  text: TextSpan(
                    text: 'You have accessed our app (',
                    style: themeFont(),
                    children: [
                      TextSpan(
                        text: 'App',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ') and/or our Website www.huddleandscore.com (',
                      ),
                      TextSpan(
                        text: 'Website',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ').',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'The domain name ',
                    style: themeFont(),
                    children: [
                      TextSpan(
                        text: 'Huddle And Score',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ' is owned by ',
                      ),
                      TextSpan(
                        text: 'Grownited Private Limited',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text:
                            ', a private company incorporated under the (Indian) Companies Act, 2013 bearing CIN U74999GJ2021PTC123718 and having its registered office at 301-305, 3rd Floor, Surbhi Complex, Nr. Municipal Market C.G. Road, Navrangpura, Ahmedabad 380009, Gujarat, India (',
                      ),
                      TextSpan(
                        text: 'Huddle And Score',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ' or ',
                      ),
                      TextSpan(
                        text: 'us',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ' or ',
                      ),
                      TextSpan(
                        text: 'we',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ' or ',
                      ),
                      TextSpan(
                        text: 'our',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text: ' or ',
                      ),
                      TextSpan(
                        text: 'Company',
                        style: themeFont(w: 'b'),
                      ),
                      TextSpan(
                        text:
                            '). The Website and/or App are internet based portals owned and operated by Huddle And Score.',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'These Terms and Conditions of use (',
                    style: themeFont(),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

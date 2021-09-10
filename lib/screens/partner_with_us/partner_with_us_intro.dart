import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/partner_with_us/how_it_works.dart';

import '../../constants.dart';

class PartnerWithUsIntro extends StatefulWidget {
  @override
  _PartnerWithUsIntroState createState() => _PartnerWithUsIntroState();
}

class _PartnerWithUsIntroState extends State<PartnerWithUsIntro> {
  bool isFirst = true;
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
                  print("Pressed");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HowItWorks(isFirst: isFirst,),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.35,
                  child: Center(
                    child: Text(
                      'Continue',
                      style: themeFont(color: Colors.white,s:15,w:'sb'),
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
          width: w,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h*0.05,),
                Text(
                  'Partner With Us',
                  style: themeFont(
                    s: 23,
                    color: kThemeColor,
                  ),
                ),
                SizedBox(height: h*0.03,),
                showText(
                  'We\, at Huddle & Score, understand the significance of building quality relations with our partners. We recognize that our partners bring incredible value to the business and are an integral part of the community that we aim to build and foster.',
                ),
                SizedBox(height: h*0.06,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = true;
                        });
                      },
                      child: Container(
                        height: (h * (209 / kScreenH)),
                        width: (w * (173 / kScreenW)),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: (isFirst)
                                  ? kThemeColor
                                  : Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius:(isFirst)? 0:3,
                            ),
                          ],
                          border: (isFirst)
                              ? (Border.all(
                                  color: kThemeColor,
                                  style: BorderStyle.solid,
                                ))
                              : Border(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: h * (140 / kScreenH),
                              child: Image.asset(
                                'assets/images/player_2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              'Turfs',
                              style: themeFont(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: (h * (209 / kScreenH)),
                        width: (w * (173 / kScreenW)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: (!isFirst)
                                  ? kThemeColor
                                  : Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius:(!isFirst)? 0:3,
                            ),
                          ],
                          border: (!isFirst)
                              ? (Border.all(
                                  color: kThemeColor,
                                  style: BorderStyle.solid,
                                ))
                              : Border(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: h * (140 / kScreenH),
                              child: Image.asset(
                                'assets/images/player_1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              'Tournament',
                              style: themeFont(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Spacer(),
                    Text('Select a card to proceed',style:themeFont(s: 12,w:'r'))
                  ],
                ),
                SizedBox(height: h*0.033,),

                showText(
                  'Join us to become part of our community to avail the benefits that our platform offers.',
                ),
                SizedBox(height: 15,),
                showText(
                  'On listing with us, you open yourself up to a much greater audience. This increased visibility will fill your turfs up with sportspeople and ensure that your tournaments are a booming success.',
                ),
                SizedBox(height: 15,),

                showText(
                  'We are building a community that not only sports enthusiasts can count on, but one that others can also be a part of.',
                ),
              ],
            ),
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
      style: themeFont(s:14,w:'r'),
    ),
  );
}

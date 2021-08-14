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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HowItWorks(isFirst: isFirst,),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.3,
                  child: Center(
                    child: Text(
                      'Book Now',
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
          width: w,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Partner With Us',
                style: themeFont(
                  s: 23,
                  color: kThemeColor,
                ),
              ),
              showText(
                'We, at Huddle & Score, understand the significance of quality relations with our partners. We recognize the fact that our partners bring incredible value to the business as well as the community we aim to build and foster.',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                ? kThemeColor.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
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
                            child: Image.network(
                              'https://picsum.photos/200/300',
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
                            color: (isFirst)
                                ? Colors.grey.withOpacity(0.5)
                                : kThemeColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
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
                            child: Image.network(
                              'https://picsum.photos/200/300',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Tournaments',
                            style: themeFont(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              showText(
                'Join us to become part of our community and reap the benefits that our platform offers.',
              ),
              showText(
                'On listing with us, you open yourself up to a much greater audience. And because of this increased visibility, your turf will always be brimming with sportspeople, and your tournaments will be a booming success.',
              ),
              showText(
                ' We believe that we are engaging in the creation of a platform that individuals can rely on, and be happy to be a part of.',
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
      style: themeFont(),
    ),
  );
}

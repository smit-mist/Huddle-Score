import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/tournament/tournament_details.dart';
import 'package:huddle_and_score/screens/tournament/tournament_review.dart';

import '../../constants.dart';

class TournamentRegisterForm extends StatefulWidget {
  @override
  _TournamentRegisterFormState createState() => _TournamentRegisterFormState();
}

class _TournamentRegisterFormState extends State<TournamentRegisterForm> {
  bool teamName = false,
      name1 = false,
      contact1 = false,
      email1 = false,
      age1 = false,
      name2 = false,
      contact2 = false,
      email2 = false,
      age2 = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    Widget onBackDialog = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 200.0,
          width: 350.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Are you sure you want to go back?',
                style: themeFont(),
              ),
              Text(
                'If you click \'Yes, go back\', the details you filled up will be lost.',
                style: themeFont(s: 12),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TournamentDetails(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            'Yes, go back',
                            style: themeFont(color: kThemeColor, s: 13),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: kThemeColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            'No, stay on page',
                            style: themeFont(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: kThemeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

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
                  showDialog(
                      context: context,
                      builder: (BuildContext _) => onBackDialog);
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
                      builder: (_) => TournamentReview(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.3,
                  child: Center(
                    child: Text(
                      'Submit',
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.025,
                ),
                Text(
                  'Registration',
                  style: themeFont(
                    color: kThemeColor,
                    s: 23,
                  ),
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                RichText(
                  text: TextSpan(
                    style: themeFont(),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Kindly fill in the following details to register your team in ',
                      ),
                      TextSpan(
                        text: 'Vamos\' 21',
                        style: themeFont(
                          w: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      teamName = true;
                    });
                  },
                  decoration: normalTextDecoration( 'Team Name'),
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                Text(
                  'Captain details',
                  style: themeFont(s: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'All communication regarding the tournament will be done with the captain or vice-captain of the team.',
                  style: themeFont(s: 13, color: Colors.black.withOpacity(0.7)),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      name1 = true;
                    });
                  },
                  decoration: normalTextDecoration('Captain\'s Name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  //        controller: _contact,
                  onTap: () {
                    contact1 = true;
                  },
                  decoration: normalTextDecoration(
                          'Captain\'s Contact Number')
                      .copyWith(
                    prefixIcon: Container(
                      width: w * 0.15,
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            '+91',
                            style: themeFont(
                              color: Colors.grey.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            height: 25,
                            width: 1,
                            color: Color(0xFFAFAFAF),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      email1 = true;
                    });
                  },
                  decoration: normalTextDecoration('Captain\'s Email'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      age1 = true;
                    });
                  },
                  decoration: normalTextDecoration('Captain\'s Age'),
                ),
                SizedBox(
                  height: h * (0.025),
                ),
                Text(
                  'Vice Captain details',
                  style: themeFont(s: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      name2 = true;
                    });
                  },
                  decoration:
                      normalTextDecoration('Vice Captain\'s Name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  //        controller: _contact,
                  onTap: () {
                    contact2 = true;
                  },
                  decoration: normalTextDecoration(
                          'Vice Captain\'s Contact Number')
                      .copyWith(
                    prefixIcon: Container(
                      width: w * 0.15,
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            '+91',
                            style: themeFont(
                              color: Colors.grey.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            height: 25,
                            width: 1,
                            color: Color(0xFFAFAFAF),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      email2 = true;
                    });
                  },
                  decoration:
                      normalTextDecoration('Vice Captain\'s Email'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onTap: () {
                    setState(() {
                      age2 = true;
                    });
                  },
                  decoration: normalTextDecoration('Vice Captain\'s Age'),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
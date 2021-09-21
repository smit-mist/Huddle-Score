import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/models/feedback.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/repositories/feedback_repository.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class FifaReceiptScreen extends StatefulWidget {
  String bookingID;
  FifaReceiptScreen({this.bookingID});

  @override
  _FifaReceiptScreenState createState() => _FifaReceiptScreenState();
}

class _FifaReceiptScreenState extends State<FifaReceiptScreen> {
  List<String> first = ['Definitely', 'Maybe', 'Not at all'];
  List<String> second = [
    'Social Media',
    'Search Engine',
    'At a turf',
    'Word of mouth',
    'Other'
  ];
  FifaBookingDetails details;
  TextEditingController suggestion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double liked = 0.5;
    int firstOption = 0, secondOption = 0;
    Widget feedBackFrom = StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: h * (550 / kScreenH),
              width: w * (400 / kScreenW),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * (480 / kScreenH),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We\'d love your feedback!',
                              style: themeFont(
                                color: kThemeColor,
                                s: 20,
                                w: 'sb',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'How satisfied are you with the booking experience?',
                              style: themeFont(
                                s: 15,
                                w: 'r',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Sad'),
                                Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  value: liked,
                                  onChanged: (double nw) {
                                    setState(() {
                                      liked = nw;
                                    });
                                  },
                                ),
                                Text('Happy'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Would you recommend Huddle & Score to your friends?',
                              style: themeFont(s: 15),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        firstOption = 0;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'Definitely',
                                          style: themeFont(
                                            color: (firstOption == 0)
                                                ? kThemeColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: ((firstOption == 0)
                                              ? kThemeColor
                                              : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        firstOption = 1;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'May be',
                                          style: themeFont(
                                            color: (firstOption == 1)
                                                ? kThemeColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: ((firstOption == 1)
                                              ? kThemeColor
                                              : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        firstOption = 2;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'Not at all',
                                          style: themeFont(
                                            color: (firstOption == 2)
                                                ? kThemeColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: ((firstOption == 2)
                                              ? kThemeColor
                                              : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'How did you hear about us?',
                              style: themeFont(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      secondOption = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (120 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'Social Media',
                                        style: themeFont(
                                          color: (secondOption == 0)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 0)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      secondOption = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (120 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'Search Engine',
                                        style: themeFont(
                                          color: (secondOption == 1)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 1)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      secondOption = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (120 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'Word of mouth',
                                        style: themeFont(
                                          color: (secondOption == 2)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 2)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      secondOption = 3;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (120 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'At a turf',
                                        style: themeFont(
                                          color: (secondOption == 3)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 3)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      secondOption = 4;
                                    });
                                  },
                                  child: TextField(
                                    decoration: normalTextDecoration('Other'),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'How can we make your experience even better?',
                              style: themeFont(),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            TextField(
                              controller: suggestion,
                              decoration: normalTextDecoration(
                                'Leave a suggestion to us..',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            width: 100,
                            height: 40,
                            child: ActionButton(
                              onTap: () async {
                                print(suggestion.text + 'here22');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoadingScreen(),
                                    ));
                                await FeedBackRepository().sendFeedbackData(
                                  FeedBack(
                                    satisfied: liked.toInt(),
                                    chooseUs: '',
                                    recommendOthers: first[firstOption],
                                    comeToKnowUs: second[secondOption],
                                    suggestion: suggestion.text,
                                  ),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Fluttertoast.showToast(msg: 'Thanks for your FeedBack');
                              },
                              child: Text(
                                'Submit',
                                style: themeFont(
                                  color: Colors.white,
                                ),
                              ),
                              bgColor: kThemeColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    String uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .doc('users/$uid/records/fifa')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot == null) {
            return LoadingWidget();
          }
          if (snapshot.data == null) {
            return LoadingWidget();
          }
          if(snapshot.data.data()==null){
            return LoadingWidget();
          }

          var here = Map<String, dynamic>.from(snapshot.data.data());
          bool fnd = false;
          print("check here");
          print(here == null);
          here.forEach((key, value) {
            if (key.endsWith(widget.bookingID)) {
              fnd = true;
              details = FifaBookingDetails.fromMap(value);
            }
          });
          if (!fnd) {
            return LoadingWidget();
          } else
            return DetailShower(
              details: details,
            );
        });
  }
}

class DetailShower extends StatefulWidget {
  FifaBookingDetails details;
  DetailShower({this.details});

  @override
  _DetailShowerState createState() => _DetailShowerState();
}

class _DetailShowerState extends State<DetailShower> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double liked = 0.5;
    int firstOption = 0, secondOption = 0;
    Widget feedBackFrom = StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: h * (550 / kScreenH),
              width: w * (370 / kScreenW),
              child: Column(
                children: [
                  SizedBox(
                    height: h * (480 / kScreenH),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'We\'d love your feedback!',
                            style: themeFont(
                              color: kThemeColor,
                              s: 20,
                              w: 'sb',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'How satisfied are you with the booking experience?',
                            style: themeFont(
                              s: 15,
                              w: 'r',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Sad'),
                              Slider(
                                min: 0.0,
                                max: 100.0,
                                value: liked,
                                onChanged: (double nw) {
                                  setState(() {
                                    liked = nw;
                                  });
                                },
                              ),
                              Text('Happy'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Would you recommend Huddle & Score to your friends?',
                            style: themeFont(s: 15),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      firstOption = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'Definitely',
                                        style: themeFont(
                                          color: (firstOption == 0)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((firstOption == 0)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      firstOption = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'May be',
                                        style: themeFont(
                                          color: (firstOption == 1)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((firstOption == 1)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      firstOption = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'Not at all',
                                        style: themeFont(
                                          color: (firstOption == 2)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((firstOption == 2)
                                            ? kThemeColor
                                            : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'How did you hear about us?',
                            style: themeFont(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondOption = 0;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: w * (120 / kScreenW),
                                  child: Center(
                                    child: Text(
                                      'Social Media',
                                      style: themeFont(
                                        color: (secondOption == 0)
                                            ? kThemeColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ((secondOption == 0)
                                          ? kThemeColor
                                          : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondOption = 1;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: w * (120 / kScreenW),
                                  child: Center(
                                    child: Text(
                                      'Search Engine',
                                      style: themeFont(
                                        color: (secondOption == 1)
                                            ? kThemeColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ((secondOption == 1)
                                          ? kThemeColor
                                          : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondOption = 2;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: w * (120 / kScreenW),
                                  child: Center(
                                    child: Text(
                                      'Word of mouth',
                                      style: themeFont(
                                        color: (secondOption == 2)
                                            ? kThemeColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ((secondOption == 2)
                                          ? kThemeColor
                                          : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondOption = 3;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: w * (120 / kScreenW),
                                  child: Center(
                                    child: Text(
                                      'At a turf',
                                      style: themeFont(
                                        color: (secondOption == 3)
                                            ? kThemeColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ((secondOption == 3)
                                          ? kThemeColor
                                          : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondOption = 4;
                                  });
                                },
                                child: TextField(
                                  decoration: normalTextDecoration('Other'),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'How can we make your experience even better?',
                            style: themeFont(),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          TextField(
                            decoration: normalTextDecoration(
                                'Leave a suggestion to us..'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 100,
                          height: 40,
                          child: ActionButton(
                            child: Text(
                              'Submit',
                              style: themeFont(
                                color: Colors.white,
                              ),
                            ),
                            bgColor: kThemeColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return CommonScaffold(
        bottomBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: h * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeNavBar(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'Back',
                  style: themeFont(),
                ),
              ),
              Spacer(),
              // GestureDetector(
              //   onTap: () {
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext _) => feedBackFrom);
              //   },
              //   child: Container(
              //     height: 40,
              //     width: w * 0.45,
              //     child: Center(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Icon(
              //             Icons.download_rounded,
              //             color: Colors.white,
              //           ),
              //           Text(
              //             'Download Receipt',
              //             style: themeFont(
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: kThemeColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * (0.04),
              ),
              Text(
                'Receipt',
                style: themeFont(color: kThemeColor, s: 23, w: 'sb'),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: h * (160 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 0.1,
                        offset: Offset(3, 3))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex:2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            widget.details.data.title,
                            style: themeFont(w: 'sb', s: 14),
                          ),
                          Text(
                            widget.details.data.gameDate,
                            style: themeFont(w: 'sb', s: 14),
                          ),
                          Text(

                                widget.details.data.venue.address.join(", "),
                            style: themeFont(w: 'sb', s: 14),
                          ),
                          Text(
                            widget.details.data.time,
                            style: themeFont(w: 'sb', s: 14),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: h * (102 / kScreenH),
                        width: h * (102 / kScreenH),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            widget.details.data.poster,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: h * (220 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(3, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Your participation has been confirmed.',
                      style: themeFont(color: kThemeColor, w: 'sb', s: 14),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    DataShower(
                        type: 'Player\'s Name',
                        data: widget.details.regDetails.name),
                    DataShower(
                        type: 'Contact Number',
                        data: widget.details.regDetails.contact.toString()),
                    DataShower(
                        type: 'Email ID',
                        data: widget.details.regDetails.email),
                    DataShower(
                        type: 'Mode of Payment',
                        data: widget.details.paymentMethod),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: h * (120 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(3, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Charges',
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          '₹ ${widget.details.amount/100}',
                          style: themeFont(w: 'm'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Taxes',
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          widget.details.taxes.toString(),
                          style: themeFont(w: 'm'),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Amount',
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          '₹ ${(widget.details.taxes + widget.details.amount / 100).toString()}',
                          style: themeFont(w: 'sb'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }
}

class DataShower extends StatelessWidget {
  String type, data;
  DataShower({this.type, this.data});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.type,
            style: themeFont(w: 'm', s: 14),
          ),
          Spacer(),
          SizedBox(
            width: w * (0.35),
            child: Text(
              this.data,
              style: themeFont(w: 'm', s: 14),
            ),
          ),
        ],
      ),
    );
  }
}

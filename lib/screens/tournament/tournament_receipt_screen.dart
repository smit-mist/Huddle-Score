import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';

import '../../constants.dart';

class TournamentReceiptScreen extends StatefulWidget {
  @override
  _TournamentReceiptScreenState createState() =>
      _TournamentReceiptScreenState();
}

class _TournamentReceiptScreenState extends State<TournamentReceiptScreen> {
  double liked = 0.5;
  int firstOption = 0, secondOption = 0;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: h * (550 / kScreenH),
              width: w * (370 / kScreenW),
              child: Column(
                children: [
                  SizedBox(
                    height: h*(480/kScreenH),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'We\'d love your feedback!',
                            style: themeFont(color: kThemeColor, s: 20,w:'sb',),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'How satisfied are you with the booking experience?',
                            style: themeFont(s: 15,w:'r',),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Sad'),
                              Slider(
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
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondOption = 0;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: w * (150 / kScreenW),
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
                                  width: w * (150 / kScreenW),
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
                                  width: w * (150 / kScreenW),
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
                                  width: w * (150 / kScreenW),
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
                            decoration:
                                normalTextDecoration('Leave a suggestion to us..'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width:double.infinity,
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 100,
                          height: 40,
                          child: ActionButton(
                            child: Text('Submit',style: themeFont(color: Colors.white,),),
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
                  showDialog(
                      context: context,
                      builder: (BuildContext _) => feedBackFrom);
                },
                child: Container(
                  height: 40,
                  width: w * 0.45,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Download Receipt',
                          style: themeFont(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kThemeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * (0.04),
                ),
                Text(
                  'Receipt',
                  style: themeFont(
                    color: kThemeColor,
                    s: 23,
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: h * (333 / kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: h * (150 / kScreenH),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  'Fifa Championship',
                                  style: themeFont(w: 'b'),
                                ),
                                Text(
                                  '8 September 2021',
                                  style: themeFont(w: 'b'),
                                ),
                                Text(
                                  'LD College, Ahmedabad',
                                  style: themeFont(w: 'b'),
                                ),
                                Text(
                                  '4 p.m. onwards',
                                  style: themeFont(w: 'b'),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: h * (147 / kScreenH),
                            width: w * (134 / kScreenW),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                'https://picsum.photos/300/300',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '*All players will be required to show identity proof at the time of the tournament.',
                          style: themeFont(s: 12),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Following identity proofs will be accepted:',
                              style: themeFont(s: 12),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: themeFont(color: kThemeColor, s: 17),
                                ),
                                Text(
                                  'Aadhar Card',
                                  style: themeFont(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: themeFont(color: kThemeColor, s: 17),
                                ),
                                Text(
                                  'Driver\'s License',
                                  style: themeFont(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: themeFont(color: kThemeColor, s: 17),
                                ),
                                Text(
                                  'Voter Id',
                                  style: themeFont(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                  height: h * (400 / kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Your participation has been confirmed.',
                        style: themeFont(
                          color: kThemeColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      DataShower(type: 'Team Name', data: 'Supreme FC'),
                      DataShower(type: 'Captain', data: 'Sunil'),
                      DataShower(type: 'Phone No.', data: '9934923912'),
                      DataShower(type: 'Email Id', data: 'abc@gmail.com'),
                      DataShower(type: 'Vice Captain', data: 'Bob'),
                      DataShower(type: 'Phone No.', data: '9934923912'),
                      DataShower(type: 'Email Id', data: 'xyz@gmail.com'),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '*All communication regarding the tournament will be done with the captain or vice-captain of the team.',
                          style: themeFont(s: 12),
                        ),
                      ),
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
                  height: h * (175 / kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Amount Payable',
                        style: themeFont(s: 16, w: 'b'),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            'Charges',
                            style: themeFont(),
                          ),
                          Spacer(),
                          Text(
                            '₹ 750',
                            style: themeFont(w: 'r'),
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
                            '0',
                            style: themeFont(w: 'r'),
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
                            '₹ 750',
                            style: themeFont(w: 'r'),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
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
            style: themeFont(color: Colors.black.withOpacity(0.7)),
          ),
          Spacer(),
          SizedBox(
            width: w * (0.35),
            child: Text(
              this.data,
              style: themeFont(w: 'r'),
            ),
          ),
        ],
      ),
    );
  }
}

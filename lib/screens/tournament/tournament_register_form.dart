import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/screens/tournament/tournament_details.dart';
import 'package:huddle_and_score/screens/tournament/tournament_review.dart';

import '../../constants.dart';

class TournamentRegisterForm extends StatefulWidget {
  Tournament currentTour;
  TournamentRegisterForm({this.currentTour});

  @override
  _TournamentRegisterFormState createState() => _TournamentRegisterFormState();
}

class _TournamentRegisterFormState extends State<TournamentRegisterForm> {
  List<String> tourType = ['Select'];
  Map<String, List<String>> allCategory = {};
  List<String> selectedSub = ["Select"];
  String chosedType, chosedCat;

  bool isMultiple = false;

  TextEditingController teamName = TextEditingController(),
      capName = TextEditingController(),
      capNum = TextEditingController(),
      capEmail = TextEditingController(),
      capAge = TextEditingController(),
      vCapName = TextEditingController(),
      vCapNum = TextEditingController(),
      vCapAge = TextEditingController(),
      vCapEmail = TextEditingController();
  void preComputer() {
    print("Inside compu");
    for (int i = 0; i < widget.currentTour.rooms.length; i++) {
      if (widget.currentTour.rooms[i].category == "2") {
        isMultiple = true;
        break;
      }
    }
    chosedType = tourType[0];
    if (isMultiple) {
      tourType.add('Single');
      tourType.add('Double');
      allCategory = {
        'Single': ["Select"],
        'Double': ["Select"],
        'Select': ["Select"],
      };
      for (var x in widget.currentTour.rooms) {
        String here = "";
        here += x.subCategory;
        here += ' - ₹ ';
        here += x.fees.toString();
        if (x.category == "1")
          allCategory["Single"].add(here);
        else
          allCategory['Double'].add(here);
      }
      chosedCat = allCategory['Single'][0];
    }
  }

  @override
  void initState() {
    preComputer();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              builder: (_) => TournamentDetails(
                                tournament: widget.currentTour,
                              ),
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    print(chosedType);
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
                  RegDetails temp = RegDetails(
                    teamName: teamName.text,
                    captain: Captain(
                      fullName: capName.text,
                      email: capEmail.text,
                      contact: int.parse(capNum.text),
                      age: int.parse(
                        capAge.text,
                      ),
                    ),
                    viceCaptain: Captain(
                      fullName: vCapName.text,
                      email: vCapEmail.text,
                      contact: int.parse(vCapNum.text),
                      age: int.parse(
                        vCapAge.text,
                      ),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TournamentReview(
                        currentTour: widget.currentTour,
                        userRecord: temp,
                      ),
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
                  height: h * 0.03,
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
                        text: widget.currentTour.details.title,
                        style: themeFont(
                          w: 'b',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.027,
                ),
                Container(
                  height: h*0.1,
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width:w*0.3,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          focusColor: Colors.white,
                          value: chosedType,
                          style: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: kThemeColor,
                            size: 20,
                          ),
                          onChanged: (ok) {
                            setState(() {
                              chosedType = ok;
                              selectedSub = allCategory[chosedType];
                              chosedCat = selectedSub[0];
                            });
                          },
                          underline: Container(),
                          items: tourType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Type",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: w*0.4,
                        child: DropdownButton<String>(
                       isExpanded: true,
                          focusColor: Colors.white,
                          value: chosedCat,
                          style: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: kThemeColor,
                            size: 20,
                          ),
                          onChanged: (ok) {
                            setState(() {
                              chosedCat = ok;
                            });
                          },
                          underline: Container(),
                          items: selectedSub
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Type",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Name of your team',
                  style: themeFont(
                    s: 12,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: teamName,
                  decoration: normalTextDecoration('Team Name'),
                ),
                SizedBox(
                  height: h * 0.035,
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
                  style: themeFont(
                    s: 12,
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Text(
                  'Full Name',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: capName,
                  decoration: normalTextDecoration('Captain\'s Name'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Contact Number',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: capNum,
                  decoration: normalTextDecoration('Captain\'s Contact Number')
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
                Text(
                  'Email ID',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: capEmail,
                  decoration: normalTextDecoration('Captain\'s Email'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Age',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: capAge,
                  decoration: normalTextDecoration('Captain\'s Age'),
                ),
                SizedBox(
                  height: h * (0.035),
                ),
                Text(
                  'Vice Captain details',
                  style: themeFont(s: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Full Name',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: vCapName,
                  decoration: normalTextDecoration('Vice Captain\'s Name'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Contact Number',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: vCapNum,
                  decoration:
                      normalTextDecoration('Vice Captain\'s Contact Number')
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
                Text(
                  'Email ID',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: vCapEmail,
                  decoration: normalTextDecoration('Vice Captain\'s Email'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Age',
                  style: themeFont(s: 12),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: vCapAge,
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

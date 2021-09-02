import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/screens/tournament/tournament_details.dart';
import 'package:huddle_and_score/screens/tournament/tournament_review.dart';

import '../../constants.dart';

String nameValidator(String val) {
  if (val == null || val.isEmpty) return 'Enter Name';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(val))
    return 'Enter Valid Name';
  return null;
}

String ageValidator(String val) {
  if (val == null || val.isEmpty) return 'Enter Age';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(val))
    return 'Enter Valid Age';
  return null;
}

String emailValidator(String val) {
  if (val == null || val.isEmpty) return 'Enter Email';
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val)) return 'Please enter a valid email';
  return null;
}

String mobileNumValidator(String val) {
  if (val == null || val.isEmpty) return 'Enter Mobile Number';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(val))
    return 'Enter Valid Mobile Number';
  if (val.length != 10) return 'Enter Valid Mobile Number';
  return null;
}

class TournamentRegisterForm extends StatefulWidget {
  Tournament currentTour;
  TournamentRegisterForm({this.currentTour});

  @override
  _TournamentRegisterFormState createState() => _TournamentRegisterFormState();
}

class _TournamentRegisterFormState extends State<TournamentRegisterForm> {
  List<String> tourType = ['Select'];
  int typeOfForm = -1;

  Map<String, List<String>> allCategory = {};
  List<String> selectedSub = ["Select"];
  String chosedType, chosedCat;
  final _key = GlobalKey<FormState>();

  bool isMultiple = false;
  bool typedTeamName = false,
      typedName1 = false,
      typedName2 = false,
      typedEmail1 = false,
      typedEmail2 = false,
      typedMob1 = false,
      typedMob2 = false,
      typedAge1 = false,
      typedAge2 = false;
  TextEditingController teamName = TextEditingController(),
      name1 = TextEditingController(),
      mob1 = TextEditingController(),
      email1 = TextEditingController(),
      age1 = TextEditingController(),
      name2 = TextEditingController(),
      mob2 = TextEditingController(),
      age2 = TextEditingController(),
      email2 = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    teamName.dispose();
    name1.dispose();
    mob1.dispose();
    email1.dispose();
    age1.dispose();
    name2.dispose();
    mob2.dispose();
    email2.dispose();
    age2.dispose();
    super.dispose();
  }
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
    } else {}
  }
  /*
  * Proper team (Cap, Vice Cap) Like Cricket
  * Player 1-2 Like Badminton Doubles
  * Player 1 Single Player Game.
  * */

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
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 7,
                  spreadRadius: 1)
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
                /*
                * -1 - Means Empty Container.
                * 0 - Means Team Form (Cap, Vice Cap)
                * 1 - Means 2 Player Form (Player 1, Player 2)
                * 2 - Means 1 Player Form. (PLayer 1)
                * */
                onTap: () {
                  if (typeOfForm == -1) {
                    print("Select a Form");
                    return;
                  }
                  if (typeOfForm == 0) {
                    if (_key.currentState.validate()) {
                      RegDetails temp = RegDetails(
                        teamName: teamName.text,
                        captain: Captain(
                          fullName: name1.text,
                          email: email1.text,
                          contact: int.parse(mob1.text),
                          age: int.parse(
                            age1.text,
                          ),
                        ),
                        viceCaptain: Captain(
                          fullName: name2.text,
                          email: email2.text,
                          contact: int.parse(mob2.text),
                          age: int.parse(
                            age2.text,
                          ),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TournamentReview(
                            currentTour: widget.currentTour,
                            userRecord: temp,
                            formType: typeOfForm,
                            cat: chosedType,
                            subCat: chosedCat,
                          ),
                        ),
                      );
                    }
                  } else if (typeOfForm == 1) {
                    if (_key.currentState.validate()) {
                      RegDetails temp = RegDetails(
                        captain: Captain(
                          fullName: name1.text,
                          email: email1.text,
                          age: int.parse(age1.text),
                          contact: int.parse(mob1.text),
                        ),
                        viceCaptain: Captain(
                          fullName: name2.text,
                          email: email2.text,
                          age: int.parse(age2.text),
                          contact: int.parse(mob2.text),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TournamentReview(
                            currentTour: widget.currentTour,
                            userRecord: temp,
                            formType: typeOfForm,
                            cat: chosedType,
                            subCat: chosedCat,
                          ),
                        ),
                      );
                    }
                  } else if (typeOfForm == 2) {
                    if (_key.currentState.validate()) {
                      RegDetails temp = RegDetails(
                        captain: Captain(
                          fullName: name1.text,
                          email: email1.text,
                          age: int.parse(age1.text),
                          contact: int.parse(mob1.text),
                        ),
                        viceCaptain: Captain(),
                        teamName: "ok",
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TournamentReview(
                            currentTour: widget.currentTour,
                            userRecord: temp,
                            formType: typeOfForm,
                            cat: chosedType,
                            subCat: chosedCat,
                          ),
                        ),
                      );
                    }
                  }
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
                  height: h * 0.1,
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: w * 0.3,
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
                              if (chosedType == "Single") {
                                typeOfForm = 2;
                              } else if (chosedType == "Double") {
                                typeOfForm = 0;
                              } else {
                                typeOfForm = -1;
                              }
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
                        width: w * 0.4,
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
                // real form starts here....
                (typeOfForm == -1)
                    ? Container()
                    : (typeOfForm == 0)
                        ? Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name of your team',
                                  style: themeFont(
                                    s: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedTeamName = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedTeamName = false;
                                      });
                                    }
                                  },
                                  controller: teamName,
                                  validator: (val) {
                                    return nameValidator(val);
                                  },
                                  decoration: textFieldDecoration(
                                      'Team Name', typedTeamName),
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedName1 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedName1 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return nameValidator(val);
                                  },
                                  controller: name1,
                                  decoration: textFieldDecoration(
                                      'Captain\'s Name', typedName1),
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedMob1 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedMob1 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return mobileNumValidator(val);
                                  },
                                  keyboardType: TextInputType.phone,
                                  controller: mob1,
                                  decoration: textFieldDecoration(
                                          'Captain\'s Contact Number',
                                          typedMob1)
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedEmail1 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedEmail1 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return emailValidator(val);
                                  },
                                  controller: email1,
                                  decoration: textFieldDecoration(
                                      'Captain\'s Email', typedEmail1),
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedAge1 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedAge1 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return ageValidator(val);
                                  },
                                  controller: age1,
                                  decoration: textFieldDecoration(
                                      'Captain\'s Age', typedAge1),
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedName2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedName2 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return nameValidator(val);
                                  },
                                  controller: name2,
                                  decoration: textFieldDecoration(
                                      'Vice Captain\'s Name', typedName2),
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedMob2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedMob2 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return mobileNumValidator(val);
                                  },
                                  keyboardType: TextInputType.phone,
                                  controller: mob2,
                                  decoration: textFieldDecoration(
                                          'Vice Captain\'s Contact Number',
                                          typedMob2)
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedEmail2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedEmail2 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return emailValidator(val);
                                  },
                                  controller: email2,
                                  decoration: textFieldDecoration(
                                      'Vice Captain\'s Email', typedEmail2),
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
                                TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        typedAge2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        typedAge2 = false;
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    return ageValidator(val);
                                  },
                                  controller: age2,
                                  decoration: textFieldDecoration(
                                      'Vice Captain\'s Age', typedAge2),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        : (typeOfForm == 1)
                            ? Form(
                                key: _key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Player 1 details',
                                      style: themeFont(s: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'All communication regarding the tournament will be done with the Player 1 or Player 2',
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
                                    TextFormField(
                                      validator: (val) {
                                        return nameValidator(val);
                                      },
                                      controller: name1,
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedName1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedName1 = false;
                                          });
                                        }
                                      },
                                      decoration: textFieldDecoration(
                                          'Player 1\'s Name', typedName1),
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedMob1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedMob1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return mobileNumValidator(val);
                                      },
                                      keyboardType: TextInputType.phone,
                                      controller: mob1,
                                      decoration: textFieldDecoration(
                                              'Player 1\'s Contact Number',
                                              typedMob1)
                                          .copyWith(
                                        prefixIcon: Container(
                                          width: w * 0.15,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Text(
                                                '+91',
                                                style: themeFont(
                                                  color:
                                                      Colors.grey.withOpacity(
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedEmail1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedEmail1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return emailValidator(val);
                                      },
                                      controller: email1,
                                      decoration: textFieldDecoration(
                                          'Player 1\'s Email', typedEmail1),
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedAge1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedAge1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return ageValidator(val);
                                      },
                                      controller: age1,
                                      decoration: textFieldDecoration(
                                          'Player 1\'s Age', typedAge1),
                                    ),
                                    SizedBox(
                                      height: h * (0.035),
                                    ),
                                    Text(
                                      'Player 2 details',
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedName2 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedName2 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return nameValidator(val);
                                      },
                                      controller: name2,
                                      decoration: textFieldDecoration(
                                          'Player 2\'s Name', typedName2),
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedMob2 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedMob2 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return mobileNumValidator(val);
                                      },
                                      keyboardType: TextInputType.phone,
                                      controller: mob2,
                                      decoration: textFieldDecoration(
                                              'Player 2\'s Contact Number',
                                              typedMob2)
                                          .copyWith(
                                        prefixIcon: Container(
                                          width: w * 0.15,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Text(
                                                '+91',
                                                style: themeFont(
                                                  color:
                                                      Colors.grey.withOpacity(
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedEmail2 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedEmail2 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return emailValidator(val);
                                      },
                                      controller: email2,
                                      decoration: textFieldDecoration(
                                          'Player 2\'s Email', typedEmail2),
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedAge2 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedAge2 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return ageValidator(val);
                                      },
                                      controller: age2,
                                      decoration: textFieldDecoration(
                                          'Player 2\'s Age', typedAge2),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              )
                            : Form(
                                key: _key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Player 1 details',
                                      style: themeFont(s: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'All communication regarding the tournament will be done with the Player 1',
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedName1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedName1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return nameValidator(val);
                                      },
                                      controller: name1,
                                      decoration: textFieldDecoration(
                                          'Player 1\'s Name', typedName1),
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedMob1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedMob1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return mobileNumValidator(val);
                                      },
                                      keyboardType: TextInputType.phone,
                                      controller: mob1,
                                      decoration: textFieldDecoration(
                                              'Player 1\'s Contact Number',
                                              typedMob1)
                                          .copyWith(
                                        prefixIcon: Container(
                                          width: w * 0.15,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Text(
                                                '+91',
                                                style: themeFont(
                                                  color:
                                                      Colors.grey.withOpacity(
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedEmail1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedEmail1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return emailValidator(val);
                                      },
                                      controller: email1,
                                      decoration: textFieldDecoration(
                                          'Player 1\'s Email', typedEmail1),
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
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val.length > 0) {
                                          setState(() {
                                            typedAge1 = true;
                                          });
                                        } else {
                                          setState(() {
                                            typedAge1 = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return ageValidator(val);
                                      },
                                      controller: age1,
                                      decoration: textFieldDecoration(
                                          'Player 1\'s Age', typedAge1),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/models/captain.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/screens/tournament/tournament_review.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';

import '../../constants.dart';

String nameValidator(String val) {
  if (val == null || val.isEmpty) return 'Please enter your full name';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(val))
    return 'Enter Valid Name';
  return null;
}

String ageValidator(String val) {
  if (val == null || val.isEmpty) return 'Please enter your age';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(val))
    return 'Please enter your age';
  return null;
}

String emailValidator(String val) {
  if (val == null || val.isEmpty) return 'Please enter a valid Email ID';
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val)) return 'Please Enter a valid Email ID';
  return null;
}

String mobileNumValidator(String val) {
  if (val == null || val.isEmpty)
    return 'Please enter a valid 10-digit contact number';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(val))
    return 'Enter Valid Mobile Number';
  if (val.length != 10) return 'Please enter a valid 10-digit contact number';
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
  formType currForm = formType.noForm;
  String sport = "";

/*
  * Proper team (Cap, Vice Cap) Like Cricket
  * Player 1-2 Like Badminton Doubles
  * Player 1 Single Player Game.
  * */
  Map<String, List<String>> allCategory = {
    'Select': ['Select'],
  };
  List<String> selectedSub = ["Select"];
  String chosedType, chosedCat;
  final _key = GlobalKey<FormState>();

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
    sport = widget.currentTour.info.type;
    currForm = getFormType(sport.toLowerCase());
    if (currForm == formType.Team) {
      tourType[0] = "Team";
      allCategory = {
        'Team': ['Select'],
      };
      for (var x in widget.currentTour.rooms) {
        String here = "";
        here += x.subCategory;
        here += ' - ₹ ';
        here += x.fees.toString();
        allCategory['Team'].add(here);
      }
      chosedType = tourType[0];
      chosedCat = allCategory['Team'][0];
      selectedSub = allCategory['Team'];
    } else {
      bool isMultiple = false;
      int one = 0, two = 0;
      for (var x in widget.currentTour.rooms) {
        if (x.category == "1")
          one = 1;
        else
          two = 1;
      }
      if (one + two == 2) {
        currForm = formType.Double;
        isMultiple = true;
      } else {
        currForm = formType.Single;
      }
      if (isMultiple) {
        tourType.add('Single');
        tourType.add('Double');
        allCategory = {
          'Single': ["Select"],
          'Double': ["Select"],
          'Select': ["Select"],
        };
        for (var x in widget.currentTour.rooms) {
          if (x.maxSeats > x.registered.length) {
            String here = "";
            here += x.subCategory;
            here += ' - ₹ ';
            here += x.fees.toString();
            if (x.category == "1")
              allCategory["Single"].add(here);
            else
              allCategory['Double'].add(here);
          }
        }
        chosedCat = allCategory['Single'][0];
      } else {
        tourType[0] = "Single";
        allCategory = {
          'Single': ['Select'],
        };
        for (var x in widget.currentTour.rooms) {
          String here = "";
          here += x.subCategory;
          here += ' - ₹ ';
          here += x.fees.toString();
          allCategory['Single'].add(here);
        }
        chosedType = tourType[0];
        chosedCat = allCategory['Single'][0];
        selectedSub = allCategory['Single'];
      }
      currForm = formType.noForm;
    }
  }

  @override
  void initState() {
    preComputer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // typeOfForm = 1;
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
                        Navigator.pop(context);
                        Navigator.pop(context);
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
                if (currForm == formType.noForm) {
                  Fluttertoast.showToast(msg: 'Please Select a Type of Form');
                  return;
                }
                if (chosedCat != 'Select' && chosedType != 'Select') {
                  if (currForm == formType.Team) {
                    if (_key.currentState.validate()) {
                      RegDetails temp = RegDetails(
                        teamName: teamName.text.trim(),
                        captain: Captain(
                          fullName: name1.text.trim(),
                          email: email1.text.trim(),
                          contact: int.parse(mob1.text.trim()),
                          age: int.parse(
                            age1.text.trim(),
                          ),
                        ),
                        viceCaptain: Captain(
                          fullName: name2.text.trim(),
                          email: email2.text.trim(),
                          contact: int.parse(mob2.text.trim()),
                          age: int.parse(
                            age2.text.trim(),
                          ),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TournamentReview(
                            currentTour: widget.currentTour,
                            userRecord: temp,
                            currForm: currForm,
                            cat: chosedType,
                            subCat: chosedCat,
                          ),
                        ),
                      );
                    }
                  } else if (currForm == formType.Double) {
                    if (_key.currentState.validate()) {
                      RegDetails temp = RegDetails(
                        teamName: teamName.text.trim(),
                        captain: Captain(
                          fullName: name1.text.trim(),
                          email: email1.text.trim(),
                          age: int.parse(age1.text.trim()),
                          contact: int.parse(mob1.text.trim()),
                        ),
                        viceCaptain: Captain(
                          fullName: name2.text.trim(),
                          email: email2.text.trim(),
                          age: int.parse(age2.text.trim()),
                          contact: int.parse(mob2.text.trim()),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TournamentReview(
                            currentTour: widget.currentTour,
                            userRecord: temp,
                            currForm: currForm,
                            cat: chosedType,
                            subCat: chosedCat,
                          ),
                        ),
                      );
                    }
                  } else {
                    if (_key.currentState.validate()) {
                      RegDetails temp = RegDetails(
                        captain: Captain(
                          fullName: name1.text.trim(),
                          email: email1.text.trim(),
                          age: int.parse(age1.text.trim()),
                          contact: int.parse(mob1.text.trim()),
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
                            currForm: currForm,
                            cat: chosedType,
                            subCat: chosedCat,
                          ),
                        ),
                      );
                    }
                  }
                } else {
                  Fluttertoast.showToast(msg: 'Please Select a Category');
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
      child: Container(
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
                      text: '${widget.currentTour.details.title}.',
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
                              currForm = formType.Single;
                            } else if (chosedType == "Double") {
                              currForm = formType.Double;
                            } else if (chosedType == "Team") {
                              currForm = formType.Team;
                            } else {
                              currForm = formType.noForm;
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
                          "Select",
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
              (currForm == formType.noForm)
                  ? Container()
                  : (currForm == formType.Team)
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
                                  w: 'r',
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
                                        'Captain\'s Contact Number', typedMob1)
                                    .copyWith(
                                  prefixIcon: Container(
                                    width: w * 0.15,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          '+91',
                                          style: themeFont(),
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
                                height: h * (0.045),
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
                                          style: themeFont(),
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
                      : (currForm == formType.Double)
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
                                    'Player 1 Details',
                                    style: themeFont(s: 15),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Further communication will be carried out via the contact details you provide below.',
                                    style: themeFont(
                                      s: 12,
                                      w: 'r',
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
                                              style: themeFont(),
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
                                        'Player 1\'s Email ID', typedEmail1),
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
                                    height: h * (0.055),
                                  ),
                                  Text(
                                    'Player 2 Details',
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
                                              style: themeFont(),
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
                                        'Player 2\'s Email ID', typedEmail2),
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
                                    'Player 1 Details',
                                    style: themeFont(s: 15),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Further communication will be carried out via the contact details you provide below.',
                                    style: themeFont(
                                      s: 12,
                                      w: 'r',
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
                                              style: themeFont(),
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
                                        'Player 1\'s Email ID', typedEmail1),
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
    );
  }
}

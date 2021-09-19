import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/fifa.dart';
import 'package:huddle_and_score/models/fifa_record.dart';
import 'package:huddle_and_score/screens/fifa/fifa_review.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';

import '../../constants.dart';

String nameValidator(String val) {
  if (val == null || val.isEmpty) return 'Please enter Name';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(val))
    return 'Enter Valid Name';
  return null;
}

String emailValidator(String val) {
  if (val == null || val.isEmpty) return 'Please enter Email ID';
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val)) return 'Please enter a valid email';
  return null;
}

String mobileNumValidator(String val) {
  if (val == null || val.isEmpty) return 'Please enter Contact Number';
  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(val))
    return 'Enter Valid Mobile Number';
  if (val.length != 10) return 'Enter Valid Mobile Number';
  return null;
}

class FifaRegistrationForm extends StatefulWidget {
  final Fifa fifa;
  FifaRegistrationForm({this.fifa});
  @override
  _FifaRegistrationFormState createState() => _FifaRegistrationFormState();
}

class _FifaRegistrationFormState extends State<FifaRegistrationForm> {
  bool typedName = false, typedContact = false, typedEmail = false;
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    contact.dispose();
    email.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();
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
    return CommonScaffold(
        bottomBar: Container(
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
                  print("pressed");
                  if (_key.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FifaReview(
                          currFifa: widget.fifa,
                          record: FifaRecord(
                            email: email.text.trim(),
                            name: name.text.trim(),
                            number: int.parse(contact.text.trim()),
                          ),
                        ),
                      ),
                    );
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
                  style: themeFont(color: kThemeColor, s: 23, w: 'sb'),
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
                            'Kindly fill in the following details to register in ',
                        style: themeFont(s: 14, w: 'm'),
                      ),
                      TextSpan(
                        text: widget.fifa.details.title ?? 'Fifa',
                        style: themeFont(
                          w: 'b',
                          s: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Further communication will be carried out via the contact details you provide below.',
                  style: themeFont(s: 15, w: 'm'),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: themeFont(s: 12, w: 'm'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) {
                          return nameValidator(val);
                        },
                        controller: name,
                        onChanged: (val) {
                          if (val.length > 0) {
                            setState(() {
                              typedName = true;
                            });
                          } else {
                            setState(() {
                              typedName = false;
                            });
                          }
                        },
                        decoration:
                            textFieldDecoration('Your Full Name', typedName),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Contact Number',
                        style: themeFont(s: 12, w: 'm'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) {
                          return mobileNumValidator(val);
                        },
                        onChanged: (val) {
                          if (val.length > 0) {
                            setState(() {
                              typedContact = true;
                            });
                          } else {
                            setState(() {
                              typedContact = false;
                            });
                          }
                        },
                        controller: contact,
                        decoration: textFieldDecoration(
                                'Your Contact Number', typedContact)
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
                        style: themeFont(s: 12, w: 'm'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) {
                          return emailValidator(val);
                        },
                        onChanged: (val) {
                          if (val.length > 0) {
                            setState(() {
                              typedEmail = true;
                            });
                          } else {
                            setState(() {
                              typedEmail = false;
                            });
                          }
                        },
                        controller: email,
                        decoration:
                            textFieldDecoration('Your Email ID', typedEmail),
                      ),
                      SizedBox(
                        height: 15,
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

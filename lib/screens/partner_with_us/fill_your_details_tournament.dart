import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/forms/forms_bloc.dart';
import 'package:huddle_and_score/models/partner_details.dart';
import 'package:huddle_and_score/screens/partner_with_us/thank_you.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class FillYourDetailsTournament extends StatefulWidget {
  @override
  _FillYourDetailsTournamentState createState() =>
      _FillYourDetailsTournamentState();
}

class _FillYourDetailsTournamentState extends State<FillYourDetailsTournament> {
  final _key = GlobalKey<FormState>();
  FormsBloc _bloc;
  bool typedName = false, typedMob = false, typedTour = false,typedEmail = false;
  String city = "Ahmd", statee = "Gujarat", tournamentType = "Blitz";
  TextEditingController _name = TextEditingController(),
      _contact = TextEditingController(),
      _emailId = TextEditingController(),
      _nameTour = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _contact.dispose();
    _emailId.dispose();
    _nameTour.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<FormsBloc>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

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
                spreadRadius: 1,
              ),
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
                  if (_key.currentState.validate()) {
                    _bloc.add(
                      PartnerTourSubmit(
                        detailsTour: PartnerDetailsTour(
                          email: _emailId.text,
                          city: city,
                          tourType: tournamentType,
                          state: statee,
                          name: _name.text,
                          type: 'tour',
                          contactNumber: int.parse(_contact.text),
                          tourName: _nameTour.text,
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
        body: BlocListener<FormsBloc, FormsState>(
          listener: (context, state) {
            if (state is FormsLoading) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoadingScreen(),
                ),
              );
            } else if (state is FormsSubmitted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ThankYou(),
                ),
              );
            }
          },
          child: Container(
            height: h * 0.9,
            width: w,
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Text(
                      'Fill Your Details',
                      style: themeFont(color: kThemeColor, s: 23),
                    ),
                    SizedBox(
                      height: h * 0.025,
                    ),
                    Text(
                      'Your Full Name',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          if(val.length ==0)typedName = false;
                          else typedName = true;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty || value == null)
                          return 'Please Enter your name';
                        return null;
                      },
                      controller: _name,
                      decoration: textFieldDecoration(
                        'Full Name',typedName
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Contact Number',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          if(val.length ==0)typedMob = false;
                          else typedMob = true;
                        });
                      },
                      validator: (value) {
                        if (value.length != 10 ||
                            value.isEmpty ||
                            value == null)
                          return 'Please Enter a valid Contact Number';
                        return null;
                      },
                      controller: _contact,
                      decoration: textFieldDecoration(' ',typedMob).copyWith(
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
                      height: 10,
                    ),
                    Text(
                      'Your Email ID',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          if(val.length ==0)typedEmail = false;
                          else typedEmail = true;
                        });
                      },
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value))
                          return 'Please enter a valid Email';
                        return null;
                      },
                      controller: _emailId,
                      decoration: textFieldDecoration(
                        '',typedEmail,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'City',
                                  style: themeFont(),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.14),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    focusColor: Colors.grey.withOpacity(0.14),
                                    value: city,
                                    style: TextStyle(color: Colors.white),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kThemeColor,
                                      size: 12,
                                    ),
                                    underline: Container(),
                                    items: <String>[
                                      'Ahmd',
                                      'Surat',
                                      'Rajkot',
                                      'Mumbai',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (s) {
                                      setState(() {
                                        city = s;
                                      });
                                    },
                                    hint: Text(
                                      "City",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'State',
                                  style: themeFont(),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.14),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    focusColor: Colors.grey.withOpacity(0.14),
                                    value: statee,
                                    style: TextStyle(color: Colors.white),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kThemeColor,
                                      size: 12,
                                    ),
                                    underline: Container(),
                                    items: <String>[
                                      'Gujarat',
                                      'Maharastra',
                                      'MP',
                                      'Goa',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (s) {
                                      setState(() {
                                        statee = s;
                                      });
                                    },
                                    hint: Text(
                                      "State",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tournament Type',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        focusColor: Colors.grey.withOpacity(0.14),
                        value: tournamentType,
                        style: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: kThemeColor,
                          size: 12,
                        ),
                        underline: Container(),
                        items: <String>[
                          'Blitz',
                          'Round Robin',
                          'Knock Out',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (s) {
                          setState(() {
                            tournamentType = s;
                          });
                        },
                        hint: Text(
                          "Tournament Type",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name of Your Tournament',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          if(val.length ==0)typedTour = false;
                          else typedTour = true;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty || value == null)
                          return 'Please Enter the Name of your tournament';
                        return null;
                      },
                      controller: _nameTour,
                      decoration: textFieldDecoration(
                        '',typedTour
                      ),
                    ),
                    SizedBox(
                      height: h * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

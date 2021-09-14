import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huddle_and_score/blocs/forms/forms_bloc.dart';
import 'package:huddle_and_score/models/partner_details.dart';
import 'package:huddle_and_score/screens/partner_with_us/thank_you.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class FillYourDetailsTurf extends StatefulWidget {
  @override
  _FillYourDetailsTurfState createState() => _FillYourDetailsTurfState();
}

class _FillYourDetailsTurfState extends State<FillYourDetailsTurf> {
  FormsBloc _bloc;
  final _key = GlobalKey<FormState>();
  bool typedName = false,
      typedMob = false,
      typedEmail = false,
      typedTurf = false;
  String city = "Select a City", statee = "Select a State";
  TextEditingController _name = TextEditingController(),
      _contact = TextEditingController(),
      _emailId = TextEditingController(),
      _nameTurf = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _emailId.dispose();
    _nameTurf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> stateCity = {
      'Select a State': [
        'Select a City',
      ],
      'Gujarat': [
        'Select a City',
        'Ahmedabad',
        'Surat',
        'Baroda',
        'Jamnagar',
        'Rajkot',
      ],
      'Maharashtra': [
        'Select a City',
        'Mumbai',
        'Pune',
        'Nagpur',
        'Nashik',
        'Kolhapur',
      ],
      'Punjab': [
        'Select a City',
        'Amritsar',
        'Ludhiana',
        'Jalandhar',
        'Patiala',
        'Mohali',
      ],
      'Karnataka': [
        'Select a City',
        'Mysore',
        'Hubli-Dharwad',
        'Gulbarga',
        'Bangalore',
        'Bijapur',
      ],
      'Rajasthan': [
        'Select a City',
        'Jaipur',
        'Kota',
        'Bikaner',
        'Ajmer',
        'Jodhpur',
      ],
    };
    _bloc = BlocProvider.of<FormsBloc>(context);
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
                  if (_key.currentState.validate()) {
                    _bloc.add(PartnerTurfSubmit(
                      detailsTurf: PartnerDetailsTurf(
                        email: _emailId.text,
                        city: city,
                        state: statee,
                        name: _name.text,
                        type: 'turf',
                        contactNumber: int.parse(_contact.text),
                        turfName: _nameTurf.text,
                      ),
                    ));
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
            height: double.infinity,
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
                      'Contact Details',
                      style: themeFont(
                        color: kThemeColor,
                        s: 23,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Text(
                      'Your Full Name',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value == null)
                          return 'Please Enter your name';
                        return null;
                      },
                      controller: _name,
                      onChanged: (val) {
                        setState(() {
                          if (val.length == 0)
                            typedName = false;
                          else
                            typedName = true;
                        });
                      },
                      decoration: textFieldDecoration('Full Name', typedName),
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
                      validator: (value) {
                        if (value.length != 10 ||
                            value.isEmpty ||
                            value == null)
                          return 'Please Enter a valid contact number';
                        return null;
                      },
                      controller: _contact,
                      onChanged: (val) {
                        setState(() {
                          if (val.length == 0)
                            typedMob = false;
                          else
                            typedMob = true;
                        });
                      },
                      decoration: textFieldDecoration(' ', typedMob).copyWith(
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
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value))
                          return 'Please enter a valid email';
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          if (val.length == 0)
                            typedEmail = false;
                          else
                            typedEmail = true;
                        });
                      },
                      controller: _emailId,
                      decoration: textFieldDecoration('', typedEmail),
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
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) =>
                                        value == 'Select a State'
                                            ? 'Please Select a State'
                                            : null,
                                    isExpanded: true,
                                    focusColor: Colors.grey.withOpacity(0.14),
                                    value: statee,
                                    style: TextStyle(color: Colors.white),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kThemeColor,
                                      size: 12,
                                    ),
                                    items: stateCity.keys
                                        .toList()
                                        .map<DropdownMenuItem<String>>(
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
                                        city = 'Select a City';
                                      });
                                    },
                                    hint: Text(
                                      "State",
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
                          SizedBox(
                            width: 10,
                          ),
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
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    validator: (value) =>
                                        value == 'Select a City'
                                            ? 'Please Select a City'
                                            : null,
                                    focusColor: Colors.grey.withOpacity(0.14),
                                    value: city,
                                    style: TextStyle(color: Colors.white),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kThemeColor,
                                      size: 12,
                                    ),
                                    items: stateCity[statee]
                                        .toList()
                                        .map<DropdownMenuItem<String>>(
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
                                        fontWeight: FontWeight.w500,
                                      ),
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
                      height: 30,
                    ),
                    Text(
                      'Name of Your Turf',
                      style: themeFont(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value == null)
                          return 'Please Enter the name of your turf';
                        return null;
                      },
                      controller: _nameTurf,
                      decoration: normalTextDecoration(
                        '',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: kThemeColor,
                            child: SvgPicture.asset(
                              'assets/icons/checkbox.svg',
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: w * (320 / kScreenW),
                          child: Wrap(
                            children: [
                              Text(
                                "I agree to the ",
                                style: themeFont(
                                  s: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Terms and Conditions',
                                  style: themeFont(
                                    s: 12.0,
                                    color: Colors.black,
                                  ).copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

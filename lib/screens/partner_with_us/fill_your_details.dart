import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/partner_with_us/thank_you.dart';

import '../../constants.dart';

class FillYourDetails extends StatefulWidget {
  @override
  _FillYourDetailsState createState() => _FillYourDetailsState();
}

class _FillYourDetailsState extends State<FillYourDetails> {
  bool fullName = false, contact = false, emailId = false, nameTour = false;
  String city = "Ahmd";
//  TextEditingController _name, _contact, _emailId, _nameTour;
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
                      builder: (_) => ThankYou(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.3,
                  child: Center(
                    child: Text(
                      'List Now',
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
          height: h * 0.9,
          width: w,
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Full Name',
                style: themeFont(),
              ),
              TextField(
           //     controller: _name,
                onTap: () {
                  fullName = true;
                },
                decoration: normalTextDecoration(
                  fullName,
                  'Full Name',
                ),
              ),
              Text(
                'Your Contact Number',
                style: themeFont(),
              ),
              TextField(
        //        controller: _contact,
                onTap: () {
                  contact = true;
                },
                decoration: normalTextDecoration(contact, ' ').copyWith(
                  prefixIcon: Container(
                    width: w*0.15,
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
              Text(
                'Your Email ID',
                style: themeFont(),
              ),
              TextField(
        //        controller: _emailId,
                onTap: () {
                  emailId = true;
                },
                decoration: normalTextDecoration(
                  emailId,
                  '',
                ),
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
                  ],
                ),
              ),
              Text(
                'Tournament Type',
                style: themeFont(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              Text(
                'Name of Your Tournament',
                style: themeFont(),
              ),
              TextField(
          //      controller: _nameTour,
                onTap: () {
                  nameTour = true;
                },
                decoration: normalTextDecoration(
                  nameTour,
                  '',
                ),
              ),
              SizedBox(
                height: h * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huddle_and_score/screens/partner_with_us/thank_you.dart';

import '../../constants.dart';

class FillYourDetailsTurf extends StatefulWidget {
  @override
  _FillYourDetailsTurfState createState() => _FillYourDetailsTurfState();
}

class _FillYourDetailsTurfState extends State<FillYourDetailsTurf> {
  String city = "Ahmd";
  String statee = "Gujarat";
  TextEditingController _name = TextEditingController(),
      _contact = TextEditingController(),
      _emailId = TextEditingController(),
      _nameTurf = TextEditingController();
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
          height: double.infinity,
          width: w,
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h*0.05,),
                Text(
                  'Contact Details',
                  style: themeFont(
                    color: kThemeColor,
                    s: 23,
                  ),
                ),
                SizedBox(height: h*0.02,),

                Text(
                  'Your Full Name',
                  style: themeFont(),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: _name,
                  decoration: normalTextDecoration(
                    'Full Name',
                  ),
                ),
                SizedBox(height: 10,),

                Text(
                  'Your Contact Number',
                  style: themeFont(),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: _contact,
                  decoration: normalTextDecoration(' ').copyWith(
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
                SizedBox(height: 10,),

                Text(
                  'Your Email ID',
                  style: themeFont(),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: _emailId,
                  decoration: normalTextDecoration(
                    '',
                  ),
                ),
                SizedBox(height: 10,),

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
                              height: 10,
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
                              height: 10,
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
                                  'Goa',
                                  'Kerala ',
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
                SizedBox(height: 10,),

                Text(
                  'Name of Your Turf',
                  style: themeFont(),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: _nameTurf,
                  decoration: normalTextDecoration(
                    '',
                  ),
                ),
                SizedBox(height: 20,),

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
                      width: w * (330 / kScreenW),
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
                              ).copyWith(decoration: TextDecoration.underline),
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
    );
  }
}
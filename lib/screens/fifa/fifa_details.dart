import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/data_shower.dart';

import 'fifa_registration_form.dart';

List<String> first = [
  'Winners',
  'Runners Up',
  'Best Goalkeeper',
  'Best Defender',
  'Man of the match',
];
List<String> second = [
  '₹ 30,000',
  '₹ 15,000',
  '₹ 1,000',
  '₹ 1,000',
  'Vouchers'
];

class FifaDetails extends StatefulWidget {
  @override
  _FifaDetailsState createState() => _FifaDetailsState();
}

class _FifaDetailsState extends State<FifaDetails> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
                      builder: (_) => FifaRegistrationForm(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: w * 0.3,
                  child: Center(
                    child: Text(
                      'Register',
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
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: w,
          height: h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Vamos\' 21',
                      style: themeFont(
                        color: kThemeColor,
                        s: 23,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.share),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: h * (390 / kScreenH),
                  width: double.infinity,
                  child: Image.network(
                    'https://picsum.photos/200/400',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                    style: themeFont(s: 12),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Kindly go through rules and regulations of the tournament before registering.',
                    style: themeFont(s: 12),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Download Rulebook',
                    style: themeFont(s: 12, color: kThemeColor).copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: double.infinity,
                    height: h * (260 / kScreenH),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.infinity,
                          height: h * (50 / kScreenH),
                          child: Center(
                            child: Text(
                              'Oops! No more room left.',
                              style: themeFont(),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(9),
                                topRight: Radius.circular(9)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DataShower(
                          type: 'Tournament Timeline',
                          data: '18- 21 March 2020',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Venue',
                                style: themeFont(
                                    color: Colors.black.withOpacity(0.7),
                                    s: 13),
                              ),
                              Spacer(),
                              SizedBox(
                                width: w * (0.35),
                                child: Column(
                                  children: [
                                    Text(
                                      'ARA, Sindhu Bhavan road, Ahmedabad',
                                      style: themeFont(s: 13),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'View in ',
                                          style: themeFont(s: 12),
                                        ),
                                        Text(
                                          'Maps',
                                          style: themeFont(
                                                  s: 12, color: kThemeColor)
                                              .copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DataShower(
                          type: 'Category',
                          data: '15 and above',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DataShower(
                          type: 'Booking Deadline',
                          data: '22th Feb 2020',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(2, 2))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: double.infinity,
                    height: (isExpanded ? 0.42 * h : 0.3 * h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(2, 2))
                      ],
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1),
                      height: (isExpanded ? 0.42 * h : 0.3 * h),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Prize pool',
                              style: themeFont(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: h * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 2,
                                    itemBuilder: (_, ind) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            first[ind],
                                            style: themeFont(),
                                          ),
                                          Text(
                                            second[ind],
                                            style: themeFont(
                                              s: (ind == 0 ? 20 : 18),
                                              w: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          (isExpanded == false
                              ? Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Text(
                                          'And many more... ',
                                          style: themeFont(
                                            color: Colors.black.withOpacity(
                                              0.7,
                                            ),
                                            s: 10,
                                          ),
                                        ),
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isExpanded = true;
                                            });
                                          },
                                          child: Text(
                                            'View all prizes',
                                            style: themeFont(
                                                    color: kThemeColor, s: 10)
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: kThemeColor,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Container(
                                      child: Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              width: double.infinity,
                                              // height: h * 0.2,
                                              child: ListView.separated(
                                                separatorBuilder: (_, ind) {
                                                  return SizedBox(
                                                    height: 10,
                                                  );
                                                },
                                                itemCount: first.length - 2,
                                                itemBuilder: (_, ind) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        first[ind + 2],
                                                        style: themeFont(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                      Text(
                                                        second[ind + 2],
                                                        style: themeFont(),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isExpanded = false;
                                                  });
                                                },
                                                child: Text(
                                                  'View less prizes',
                                                  style: themeFont(
                                                          color: kThemeColor,
                                                          s: 10)
                                                      .copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_up_sharp,
                                                color: kThemeColor,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: double.infinity,
                    height: h * (170 / kScreenH),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 12),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'More Information',
                              style: themeFont(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DataShower(
                          type: 'Registration Fee',
                          data: '₹ 250 per head',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DataShower(
                          type: 'Time',
                          data: '4 p.m. onwards',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DataShower(
                          type: 'Mode',
                          data: '1v1',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(2, 2))
                      ],
                    ),
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
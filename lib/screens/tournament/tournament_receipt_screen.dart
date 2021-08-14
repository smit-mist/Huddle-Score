import 'package:flutter/material.dart';

import '../../constants.dart';

class TournamentReceiptScreen extends StatelessWidget {
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
              Container(
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
                            height:h*(150/kScreenH),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  'Fifa Championship',
                                  style: themeFont(w: FontWeight.bold),
                                ),
                                Text(
                                  '8 September 2021',
                                  style: themeFont(w: FontWeight.bold),
                                ),
                                Text(
                                  'LD College, Ahmedabad',
                                  style: themeFont(w: FontWeight.bold),
                                ),
                                Text(
                                  '4 p.m. onwards',
                                  style: themeFont(w: FontWeight.bold),
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
                      SizedBox(height: 1,),
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
                        style: themeFont(s: 16, w: FontWeight.bold),
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
                            style: themeFont(w: FontWeight.w600),
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
                            style: themeFont(w: FontWeight.w600),
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
                            style: themeFont(w: FontWeight.w600),
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
                SizedBox(height: 20,),
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
              style: themeFont(w: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

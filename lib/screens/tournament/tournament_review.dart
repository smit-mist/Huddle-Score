import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/tournaments_repository.dart';
import 'package:huddle_and_score/screens/tournament/tournament_receipt_screen.dart';
import 'package:huddle_and_score/screens/widgets/bottom_bar_widget.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants.dart';

class TournamentReview extends StatefulWidget {
  Tournament currentTour;
  RegDetails userRecord;
  TournamentReview({@required this.currentTour, @required this.userRecord});

  @override
  _TournamentReviewState createState() => _TournamentReviewState();
}

class _TournamentReviewState extends State<TournamentReview> {
  Razorpay razorpay;
  User user = AuthRepository().getCurrentUser();
  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess() {}
  void _handlePaymentError() {}
  void _handleExternalWallet() {}
  void checkoutOptions(RegDetails regDetails) {
    var options = {
      'key': 'rzp_test_Q9uimXdoWQRLSv',
      'prefill': {
        'name': user.displayName,
        'email': user.email,
      },
      'notes': {
        'uid': user.uid,
        'payload': jsonEncode(regDetails),
      },
    };
    razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomBar(
          actionName: 'Proceed to pay',
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoadingScreen(),
              ),
            );
            await TournamentRepository().registerInTournament(
                widget.currentTour, widget.userRecord);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => TournamentReceiptScreen(),
              ),
            );
          },
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
                  'Review',
                  style: themeFont(
                    color: kThemeColor,
                    s: 23,
                  ),
                ),
                SizedBox(
                  height: h * (0.04),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: h * (420 / kScreenH),
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
                        'Summary',
                        style: themeFont(w: 'm',s:16),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      DataShower(
                          type: 'Team Name', data: widget.userRecord.teamName),
                      DataShower(
                          type: 'Captain',
                          data: widget.userRecord.captain.fullName),
                      DataShower(
                          type: 'Phone No.',
                          data: widget.userRecord.captain.contact.toString()),
                      DataShower(
                          type: 'Email Id',
                          data: widget.userRecord.captain.email),
                      DataShower(
                          type: 'Age',
                          data: widget.userRecord.captain.age.toString()),
                      DataShower(
                          type: 'Vice Captain',
                          data: widget.userRecord.viceCaptain.fullName),
                      DataShower(
                          type: 'Phone No.',
                          data: widget.userRecord.captain.contact.toString()),
                      DataShower(
                          type: 'Email Id',
                          data: widget.userRecord.viceCaptain.email),
                      DataShower(
                          type: 'Age',
                          data: widget.userRecord.viceCaptain.age.toString()),
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
                        style: themeFont(s: 16, w: 'm'),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            'Charges',
                            style: themeFont(s:12,w:'m',),
                          ),
                          Spacer(),
                          Text(
                            '₹ ${widget.currentTour.info.registrationFee}',
                            style: themeFont(s:12,w:'m',),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Taxes',
                            style: themeFont(s:12,w:'m',),
                          ),
                          Spacer(),
                          Text(
                            '0',
                            style: themeFont(s:12,w:'m',),
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
                            style: themeFont(s:15,w:'m',),
                          ),
                          Spacer(),
                          Text(
                            '₹ ${widget.currentTour.info.registrationFee}',
                            style: themeFont(s:15,w:'sb',),
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
            style: themeFont(s:13,w:'m',),
          ),
          Spacer(),
          SizedBox(
            width: w * (0.35),
            child: Text(
              this.data,
              style: themeFont(w: 'sb',s:14),
            ),
          ),
        ],
      ),
    );
  }
}

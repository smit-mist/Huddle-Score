import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/tournaments_repository.dart';
import 'package:huddle_and_score/screens/tournament/tournament_receipt_screen.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants.dart';

class TournamentReview extends StatefulWidget {
  Tournament currentTour;
  RegDetails userRecord;
  int formType;
  TournamentReview(
      {@required this.currentTour,
      @required this.userRecord,
      @required this.formType});

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TournamentReceiptScreen(),
      ),
    );
    print(response.paymentId);
    Fluttertoast.showToast(msg: "Success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("${response.message} hereherehere");
    Fluttertoast.showToast(msg: "Error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    Fluttertoast.showToast(msg: "External");
  }

  void checkoutOptions(RegDetails regDetails) {
    var options = {
      'key': 'rzp_test_Q9uimXdoWQRLSv',
      'prefill': {
        'name': user.displayName,
        'email': user.email,
      },
      'currency': 'INR',
      'amount': 500,
      'order_id': widget.currentTour.orderId,
      'notes': {
        'uid': user.uid,
        'payload': jsonEncode(RegDetails().toMap(regDetails)),
      },
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print(widget.userRecord.captain.fullName);
    print(widget.userRecord.viceCaptain.fullName);
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
              spreadRadius: 1,
            )
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
                onTap: () async {
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
                child: GestureDetector(
                  onTap: () {
                    checkoutOptions(widget.userRecord);
                  },
                  child: Container(
                    height: 40,
                    width: w * 0.35,
                    child: Center(
                      child: Text(
                        'Proceed to pay',
                        style: themeFont(color: Colors.white, s: 15, w: 'sb'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kThemeColor,
                    ),
                  ),
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
                  height: h * ((widget.formType == 0?400:(widget.formType == 1)?370:250) / kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 15,
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
                        style: themeFont(w: 'm', s: 16),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      (widget.formType == 0)
                          ? DataShower(
                              type: 'Team Name',
                              data: widget.userRecord.teamName)
                          : Container(),
                      DataShower(
                          type: (widget.formType == 0)?'Captain':'Player 1',
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
                      (widget.formType == 2)
                          ? Container()
                          : (widget.formType == 1)
                              ? DataShower(
                                  type: 'Player 2',
                                  data: widget.userRecord.viceCaptain.fullName)
                              : DataShower(
                                  type: 'Vice Captain',
                                  data: widget.userRecord.viceCaptain.fullName),
                      (widget.formType == 2)
                          ? Container()
                          : DataShower(
                          type: 'Phone No.',
                          data:
                              widget.userRecord.viceCaptain.contact.toString()),
                      (widget.formType == 2)
                          ? Container()
                          : DataShower(
                          type: 'Email Id',
                          data: widget.userRecord.viceCaptain.email),
                      (widget.formType == 2)
                          ? Container()
                          : DataShower(
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
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Amount Payable',
                        style: themeFont(s: 16, w: 'b'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Charges',
                            style: themeFont(s: 12, w: 'm'),
                          ),
                          Spacer(),
                          Text(
                            '₹ 10}',
                            style: themeFont(s: 12, w: 'm'),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Taxes',
                            style: themeFont(s: 12, w: 'm'),
                          ),
                          Spacer(),
                          Text(
                            '0',
                            style: themeFont(s: 12, w: 'm'),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Amount',
                            style: themeFont(s: 15, w: 'm'),
                          ),
                          Spacer(),
                          Text(
                            '₹ 10',
                            style: themeFont(s: 15, w: 'sb'),
                          )
                        ],
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
            style: themeFont(s: 14, w: 'm'),
          ),
          Spacer(),
          SizedBox(
            width: w * (0.35),
            child: Text(
              this.data == null ? "NO DATA" : this.data,
              style: themeFont(s: 15, w: 'sb'),
            ),
          ),
        ],
      ),
    );
  }
}

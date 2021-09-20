import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/models/captain.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/screens/static_screens/booking_failed.dart';
import 'package:huddle_and_score/screens/tournament/tournament_receipt_screen.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants.dart';

class TournamentReview extends StatefulWidget {
  Tournament currentTour;
  RegDetails userRecord;
  formType currForm;
  String cat, subCat;
  TournamentReview({
    @required this.currentTour,
    @required this.userRecord,
    @required this.currForm,
    @required this.cat,
    @required this.subCat,
  });

  @override
  _TournamentReviewState createState() => _TournamentReviewState();
}

class _TournamentReviewState extends State<TournamentReview> {
  Room room;
  Razorpay razorpay;
  User user = AuthRepository().getCurrentUser();
  double liked = 0.5;
  int firstOption = 0, secondOption = 0;
  void precomputer() {
    String cur = '';
    for (int i = 0; i < widget.subCat.length; i++) {
      if (widget.subCat[i] == '-') break;
      cur += widget.subCat[i];
    }
    cur = cur.trim();
    String flag = (widget.cat == 'Single' || widget.cat == 'Team') ? '1' : '2';
    for (var x in widget.currentTour.rooms) {
      bool ok = x.category == flag && x.subCategory == cur;
      if (ok) {
        room = x;
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    precomputer();
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
    print(response);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TournamentReceiptGenerator(
          bookingId: response.paymentId,
        ),
      ),
    );
    print(response.paymentId);
    Fluttertoast.showToast(msg: "Success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("${response.message} hereherehere");
    Fluttertoast.showToast(msg: "Error");
    Navigator.push(context, MaterialPageRoute(builder: (_)=>BookingFailed()));
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
      'amount': room.fees * 100,
      'order_id': room.orderId,
      'notes': {
        'uid': user.uid,
        'payload': jsonEncode(
          Captain().toMap(regDetails.captain),
        ),
        'team': (widget.currForm != formType.Single)
            ? widget.userRecord.teamName
            : null,
        'payload2': widget.currForm != formType.Single
            ? jsonEncode(
                Captain().toMap(regDetails.viceCaptain),
              )
            : null,
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
    return CommonScaffold(
        bottomBar: Container(
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
            ],
          ),
        ),
        child: Container(
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
                  'Registration Summary',
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
                  height: h *
                      ((widget.currForm == formType.Team
                              ? 400
                              : (widget.currForm == formType.Double)
                                  ? 370
                                  : 250) /
                          kScreenH),
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
                        'Team Details',
                        style: themeFont(w: 'm', s: 16),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      (widget.currForm == formType.Team)
                          ? DataShower(
                              type: 'Team Name',
                              data: widget.userRecord.teamName)
                          : Container(),
                      DataShower(
                          type: (widget.currForm == formType.Team)
                              ? 'Captain\'s Name'
                              : 'Player 1 Name',
                          data: widget.userRecord.captain.fullName),
                      DataShower(
                          type: 'Contact Number',
                          data: widget.userRecord.captain.contact.toString()),
                      DataShower(
                          type: 'Email ID',
                          data: widget.userRecord.captain.email),
                      DataShower(
                          type: 'Age',
                          data: widget.userRecord.captain.age.toString()),
                      (widget.currForm == formType.Single)
                          ? Container()
                          : (widget.currForm == formType.Double)
                              ? DataShower(
                                  type: 'Player 2 Name',
                                  data: widget.userRecord.viceCaptain.fullName)
                              : DataShower(
                                  type: 'Vice Captain\'s Name',
                                  data: widget.userRecord.viceCaptain.fullName),
                      (widget.currForm == formType.Single)
                          ? Container()
                          : DataShower(
                              type: 'Contact Number',
                              data: widget.userRecord.viceCaptain.contact
                                  .toString()),
                      (widget.currForm == formType.Single)
                          ? Container()
                          : DataShower(
                              type: 'Email ID',
                              data: widget.userRecord.viceCaptain.email),
                      (widget.currForm == formType.Single)
                          ? Container()
                          : DataShower(
                              type: 'Age',
                              data:
                                  widget.userRecord.viceCaptain.age.toString()),
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
                            '₹ ${room.fees}',
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
                            '₹ ${room.fees}',
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
            this.type ?? "This is null",
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

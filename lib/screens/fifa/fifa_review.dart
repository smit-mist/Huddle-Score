import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/fifa.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/models/fifa_record.dart';
import 'package:huddle_and_score/models/user.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/user_repository.dart';
import 'package:huddle_and_score/screens/fifa/fifa_receipt_screen.dart';
import 'package:huddle_and_score/screens/static_screens/booking_failed.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants.dart';

class FifaReview extends StatefulWidget {
  final Fifa currFifa;
  final FifaRecord record;
  FifaReview({
    this.currFifa,
    this.record,
  });

  @override
  _FifaReviewState createState() => _FifaReviewState();
}

class _FifaReviewState extends State<FifaReview> {
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FifaReceiptScreen(bookingID: response.paymentId,freshBook: true,
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

  void checkoutOptions(FifaRecord regDetails) {
    print(widget.currFifa.info.registrationFee);
    var options = {
      'key': 'rzp_test_Q9uimXdoWQRLSv',
      'prefill': {
        'name': user.displayName,
        'email': user.email,
      },
      'currency': 'INR',
      'amount': widget.currFifa.info.registrationFee * 100,
      'order_id': widget.currFifa.orderId,
      'notes': {
        'uid': user.uid,
        'payload': jsonEncode(FifaRecord().toMap(regDetails)),
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
                  checkoutOptions(widget.record);
                },
                child: Container(
                  height: 40,
                  width: w * 0.4,
                  child: Center(
                    child: Text(
                      'Proceed to Pay',
                      style: themeFont(color: Colors.white),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * (0.04),
              ),
              Text(
                'Registration Summary',
                style: themeFont(color: kThemeColor, s: 23, w: 'sb'),
              ),
              SizedBox(
                height: h * (0.04),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: h * (190 / kScreenH),
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
                      'Player Details',
                      style: themeFont(w: 'm', s: 16),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    DataShower(type: 'Name', data: widget.record.name),
                    DataShower(
                        type: 'Contact Number',
                        data: widget.record.number.toString()),
                    DataShower(type: 'Email ID', data: widget.record.email),
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
                height: h * (165 / kScreenH),
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
                    SizedBox(
                      height: 1,
                    ),
                    SizedBox(
                      height: 1,
                    ),

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
                          style: themeFont(w: 'm', s: 12),
                        ),
                        Spacer(),
                        Text(
                          '₹ ${widget.currFifa.info.registrationFee}',
                          style: themeFont(w: 'm', s: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Taxes',
                          style: themeFont(w: 'm', s: 12),
                        ),
                        Spacer(),
                        Text(
                          '0',
                          style: themeFont(w: 'm', s: 12),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    //  SizedBox(height: 1,),
                    Row(
                      children: [
                        Text(
                          'Total Amount',
                          style: themeFont(w: 'm', s: 15),
                        ),
                        Spacer(),
                        Text(
                          '₹ ${widget.currFifa.info.registrationFee}',
                          style: themeFont(w: 'sb', s: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1,
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
            style: themeFont(w: 'm', s: 14),
          ),
          Spacer(),
          SizedBox(
            width: w * (0.35),
            child: Text(
              this.data,
              style: themeFont(w: 'm', s: 15),
            ),
          ),
        ],
      ),
    );
  }
}

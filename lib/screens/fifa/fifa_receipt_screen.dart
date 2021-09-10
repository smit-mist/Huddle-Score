import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/fifa.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';

class FifaReceiptScreen extends StatefulWidget {
  String bookingID;
  FifaReceiptScreen({this.bookingID});

  @override
  _FifaReceiptScreenState createState() => _FifaReceiptScreenState();
}

class _FifaReceiptScreenState extends State<FifaReceiptScreen> {
  FifaBookingDetails details;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    String uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
      stream: FirebaseFirestore.instance.doc('users/$uid/records/fifa').snapshots(),
      builder: (context, snapshot) {
        if(snapshot == null){
          return LoadingWidget();
        }
        if(snapshot.data == null){
          return LoadingWidget();

        }

        var here =Map<String,dynamic>.from(snapshot.data.data());
        bool fnd = false;

        here.forEach((key, value) {
          if(key.endsWith(widget.bookingID)){

            fnd = true;
            details = FifaBookingDetails.fromMap(value);
          }
        });
        if(!fnd){
          return LoadingWidget();
        }
        else
          return DetailShower(details: details,);

      }
    );
  }
}
class DetailShower extends StatefulWidget {
  FifaBookingDetails details;
  DetailShower({this.details});

  @override
  _DetailShowerState createState() => _DetailShowerState();
}

class _DetailShowerState extends State<DetailShower> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: w,
          height: h * 0.08,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 0.5)
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * (0.04),
              ),
              Text(
                'Receipt',
                style: themeFont(color: kThemeColor, s: 23, w: 'sb'),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: h * (150 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 0.1,
                        offset: Offset(3, 3))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          widget.details.data.title,
                          style: themeFont(w: 'sb', s: 14),
                        ),
                        Text(
                          getShorter(widget.details.data.gameDate),
                          style: themeFont(w: 'sb', s: 14),
                        ),
                        Text(
                            getShorter(widget.details.data.venue.address.join(", ")),
                          style: themeFont(w: 'sb', s: 14),
                        ),
                        Text(
                          getShorter(widget.details.data.time),
                          style: themeFont(w: 'sb', s: 14),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                    Container(
                      height: h * (102 / kScreenH),
                      width: h * (102 / kScreenH),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          widget.details.data.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: h * (220 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(3, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Your participation has been confirmed.',
                      style: themeFont(color: kThemeColor, w: 'sb', s: 14),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    DataShower(type: 'Player\'s Name', data: widget.details.regDetails.name),
                    DataShower(type: 'Contact Number', data: widget.details.regDetails.contact.toString()),
                    DataShower(type: 'Email ID', data: widget.details.regDetails.email),
                    DataShower(type: 'Mode of Payment', data: widget.details.paymentMethod),
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
                height: h * (120 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(3, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Charges',
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          '₹ ${widget.details.amount/100}',
                          style: themeFont(w: 'r'),
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
                          widget.details.taxes.toString(),
                          style: themeFont(w: 'r'),
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
                          '₹ ${(widget.details.taxes+widget.details.amount/100).toString()}',
                          style: themeFont(w: 'r'),
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
              style: themeFont(w: 'm', s: 14),
            ),
          ),
        ],
      ),
    );
  }
}

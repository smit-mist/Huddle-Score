import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';

import '../../constants.dart';
import '../home_navbar_screen.dart';

class TournamentReceiptGenerator extends StatefulWidget {
  String bookingId;
  TournamentReceiptGenerator({this.bookingId});
  @override
  _TournamentReceiptGeneratorState createState() =>
      _TournamentReceiptGeneratorState();
}

class _TournamentReceiptGeneratorState
    extends State<TournamentReceiptGenerator> {
  BookingDetails details;
  formType type;
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.doc('users/$uid/records/tour').snapshots(),
      builder: (_, snap) {
        print(snap.hasData);
        if (snap.hasData == false) return LoadingWidget();
        if(snap.data.data() == null)return LoadingWidget();
        bool fnd = false;
        var here = Map<String, dynamic>.from(snap.data.data());
        here.forEach((key, value) {
          if (key.endsWith(widget.bookingId)) {
            fnd = true;
            details = BookingDetails.fromMap(value);
            if (getFormType(details.data.type.toLowerCase()) == formType.Team) {
              type = formType.Team;
            } else {
              if (details.regDetails.viceCaptain == null ||
                  details.regDetails.viceCaptain.contact == 373737) {
                type =formType.Single;
              } else
                type =formType.Double;
            }
          }
        });

        if (fnd) {
          return TournamentReceiptScreen(
            details: details,
            currForm: type,
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class TournamentReceiptScreen extends StatefulWidget {
  BookingDetails details;
  formType currForm;
  TournamentReceiptScreen({
    @required this.details,
    @required this.currForm,
  });
  @override
  _TournamentReceiptScreenState createState() =>
      _TournamentReceiptScreenState();
}

// TODO: UPdate receipt as per form type.
class _TournamentReceiptScreenState extends State<TournamentReceiptScreen> {
  double liked = 0.5;
  int firstOption = 0, secondOption = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.currForm);
    String timeLine = "";
    var st = WeirdDateFormat(date: widget.details.data.timeLine[0]);
    var en = WeirdDateFormat(date: widget.details.data.timeLine[1]);
    timeLine += st.getDate();
    timeLine += '- ';
    timeLine += en.getDate();
    timeLine += ' ';
    timeLine += st.getMonth();
    timeLine += ' ';
    timeLine += st.getYear();
    String address = widget.details.data.venue.address.join(', ');
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print(widget.details.regDetails.captain == null);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: h * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeNavBar(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'Back',
                  style: themeFont(),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext _) => feedBackFrom);
                },
                child: Container(
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
                    w: 'sb',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: h * (333 / kScreenH),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(5, 5),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: h * (150 / kScreenH),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    widget.details.data.title,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  Text(
                                    timeLine,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  Text(
                                    address.length > 20
                                        ? address.substring(0, 17) + '...'
                                        : address,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  Text(
                                    widget.details.data.ageRec,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: h * (147 / kScreenH),
                              width: w * (120 / kScreenW),
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
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '*All players will be required to show identity proof at the time of the tournament.',
                            style: themeFont(s: 12, w: 'r'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Following documents for identification will be accepted:',
                                style: themeFont(s: 13, w: 'r'),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    '• ',
                                    style: themeFont(
                                        color: kThemeColor, s: 13, w: 'r'),
                                  ),
                                  Text(
                                    'Aadhar Card',
                                    style: themeFont(s: 13, w: 'r'),
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
                                    style: themeFont(
                                        color: kThemeColor, s: 13, w: 'r'),
                                  ),
                                  Text(
                                    'Driver\'s License',
                                    style: themeFont(
                                        color: Colors.black, s: 13, w: 'r'),
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
                                    style: themeFont(
                                        color: kThemeColor, s: 13, w: 'r'),
                                  ),
                                  Text(
                                    'Voter Id',
                                    style: themeFont(
                                        color: Colors.black, s: 13, w: 'r'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: h * (((widget.currForm == formType.Single)?250:390) / kScreenH),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(5, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        SizedBox(height: 7,),
                        Text(
                          'Your participation has been confirmed.',
                          style: themeFont(
                            color: kThemeColor,
                            s: 14,
                            w: 'm',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /*
                * -1 - Means Empty Container.
                * 0 - Means Team Form (Cap, Vice Cap)
                * 1 - Means 2 Player Form (Player 1, Player 2)
                * 2 - Means 1 Player Form. (PLayer 1)
                * */
                        (widget.currForm == formType.Team || widget.currForm == formType.Double)? DataShower(
                          type: 'Team Name',
                          data: widget.details.regDetails.teamName,
                        ):Container(),

                        DataShower(
                            type: (widget.currForm == formType.Team)?'Captain':'Player 1',
                            data: widget.details.regDetails.captain.fullName),
                        DataShower(
                            type: 'Contact Number',
                            data: widget.details.regDetails.captain.contact
                                .toString()),
                        DataShower(
                            type: 'Email Id',
                            data: widget.details.regDetails.captain.email),
                        (widget.currForm != formType.Single)
                            ? DataShower(
                                type: (widget.currForm == formType.Team)?'Vice Captain':'Player 2',
                                data: widget
                                    .details.regDetails.viceCaptain.fullName)
                            : Container(),
                        (widget.currForm != formType.Single)
                            ? DataShower(
                                type: 'Contact Number',
                                data: widget
                                    .details.regDetails.viceCaptain.contact
                                    .toString())
                            : Container(),
                        (widget.currForm != formType.Single)
                            ? DataShower(
                                type: 'Email Id',
                                data:
                                    widget.details.regDetails.viceCaptain.email)
                            : Container(),
                        DataShower(
                            type: 'Mode of Payment',
                            data: widget.details.paymentMethod),
                        SizedBox(
                          height: 1,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '*All communication regarding the tournament will be done with the captain or vice-captain of the team.',
                            style: themeFont(
                              s: 11,
                              w: 'm',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: h * (130 / kScreenH),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(5, 5),
                        )
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
                              style: themeFont(
                                s: 12,
                                w: 'm',
                              ),
                            ),
                            Spacer(),
                            Text(
                              '₹ ${widget.details.amount / 100}',
                              style: themeFont(
                                s: 12,
                                w: 'm',
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Taxes',
                              style: themeFont(
                                s: 12,
                                w: 'm',
                              ),
                            ),
                            Spacer(),
                            Text(
                              widget.details.taxes.toString(),
                              style: themeFont(
                                s: 12,
                                w: 'm',
                              ),
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
                              style: themeFont(
                                s: 15,
                                w: 'm',
                              ),
                            ),
                            Spacer(),
                            Text(
                              '₹ ${widget.details.amount / 100 + widget.details.taxes}',
                              style: themeFont(
                                s: 15,
                                w: 'sb',
                              ),
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

class DataShower extends StatelessWidget {
  String type, data;
  DataShower({this.type, this.data});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.type,
              style: themeFont(
                s: 14,
                w: 'm',
              ),
            ),
            Spacer(),
            SizedBox(
              width: w * (0.35),
              child: Text(
                this.data?? "This is NULL",
                style: themeFont(
                  s: 14,
                  w: 'sb',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

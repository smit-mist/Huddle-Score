import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huddle_and_score/blocs/button_click/button_click_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/screens/auth_and_user/sign_in_screen.dart';
import 'package:huddle_and_score/screens/tournament/tournament_register_form.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/data_shower.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

const double vertico = 4, horizonto = 9;

class TournamentDetails extends StatefulWidget {
  Tournament tournament;
  bool isReg;
  TournamentDetails({this.tournament, this.isReg});
  @override
  _TournamentDetailsState createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {
  ButtonClickBloc _bloc;
  int seatsLeft;
  String tnc;
  String timeLine;
  String combinedRegFees;
  int minPrice, maxPrice;
  WeirdDateFormat st, en, deadLine, semi, finals;
  bool canRegister;
  ScrollController ctrl;
  bool clickedOnRegister = false;
  bool userLoggedIn;
  @override
  void initState() {
    _bloc = ButtonClickBloc();
    preComputer();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void preComputer() {
    userLoggedIn = FirebaseAuth.instance.currentUser != null;

    tnc = "";
    String temp = "";
    for (int i = 0; i < widget.tournament.details.term.length; i++) {
      if (widget.tournament.details.term[i] != '|') {
        temp += widget.tournament.details.term[i];
      } else {
        tnc += temp;
        tnc += '\n';
        temp = "";
      }
    }
    tnc += temp;
    //print("This is terms:- $tnc");
    seatsLeft = widget.tournament.total - widget.tournament.totalReg.length;
    print(widget.tournament.total);
    print(widget.tournament.totalReg.length);
    timeLine = "";
    st = WeirdDateFormat(date: widget.tournament.main.timeLine[0]);
    en = WeirdDateFormat(date: widget.tournament.main.timeLine[1]);
    deadLine = WeirdDateFormat(
      date: widget.tournament.main.deadline,
    );
    semi = WeirdDateFormat(date: widget.tournament.info.dates['semiFinal']);
    finals = WeirdDateFormat(date: widget.tournament.info.dates['final']);
    timeLine += st.getDate();
    timeLine += '- ';
    timeLine += en.getDate();
    timeLine += ' ';
    timeLine += st.getMonth();
    timeLine += ' ';
    timeLine += st.getYear();
    DateTime today = DateTime.now();
    DateTime given = DateTime.parse(widget.tournament.main.deadline);
    canRegister = true;
    if (today.isAfter(given)) {
      canRegister = false;
    }
    minPrice = widget.tournament.rooms[0].fees;
    maxPrice = minPrice;
    for (int i = 0; i < widget.tournament.rooms.length; i++) {
      minPrice = min(minPrice, widget.tournament.rooms[i].fees);
      maxPrice = max(maxPrice, widget.tournament.rooms[i].fees);
    }
    combinedRegFees = "NOTHING";
    combinedRegFees = minPrice.toString() + ' - ' + maxPrice.toString();
    if (seatsLeft < 0) seatsLeft = 0;
    // print("Seats Left:- $seatsLeft");
  }

  void launchPdfUrl(String link) async => await canLaunch(link)
      ? await launch(link)
      : throw 'Could not launch $link';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    String mapUrl =
        'https://www.google.com/maps/place/${widget.tournament.main.venue.coordinates['latitude']},${widget.tournament.main.venue.coordinates['longitude']}';
    void _launchURL() async => await canLaunch(mapUrl)
        ? await launch(mapUrl)
        : throw 'Could not launch $mapUrl';
    return Stack(
      children: [
        Scaffold(
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
                    if (!userLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignInScreen(),
                        ),
                      );
                    }
                    if (widget.isReg) {
                      print('Already did');
                    } else if (canRegister == false) {
                      print('deadline finished');
                    } else if (seatsLeft <= 0) {
                    } else {
                      setState(() {
                        clickedOnRegister = true;
                      });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => TournamentRegisterForm(
                      //       currentTour: widget.tournament,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: (!userLoggedIn)
                      ? Container(
                          height: 40,
                          width: w * 0.3,
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: themeFont(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kThemeColor,
                          ),
                        )
                      : (widget.isReg)
                          ? Container(
                              child: ActionButton(
                                child: Center(
                                  child: Text(
                                    'You\'ve already registered!',
                                    style: themeFont(
                                      color: kThemeColor,
                                      s: 15,
                                    ),
                                  ),
                                ),
                                bgColor: Colors.white,
                              ),
                              height: 40,
                              width: w * 0.5,
                            )
                          : (canRegister == false)
                              ? Container(
                                  child: ActionButton(
                                    child: Center(
                                      child: Text(
                                        'Booking deadline has passed!',
                                        style: themeFont(
                                          color: kThemeColor,
                                          s: 15,
                                        ),
                                      ),
                                    ),
                                    bgColor: Colors.white,
                                  ),
                                  height: 40,
                                  width: w * 0.6,
                                )
                              : (seatsLeft <= 0)
                                  ? Container(
                                      width: w * 0.4,
                                      height: 40,
                                      child: ActionButton(
                                        child: Center(
                                          child: Text(
                                            'Booking is Full',
                                            style: themeFont(
                                              color: kThemeColor,
                                              s: 15,
                                            ),
                                          ),
                                        ),
                                        bgColor: Colors.white,
                                      ),
                                    )
                                  : Container(
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
          body: SafeArea(
            child: Container(
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
                          widget.tournament.details.title,
                          style: themeFont(
                            color: kThemeColor,
                            s: 23,
                            w: 'sb',
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            Share.share(
                              'Here is the link\n https://www.huddleandscore.com/tour/${widget.tournament.tourId}',
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: h * (390 / kScreenH),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.tournament.details.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.tournament.details.description,
                        style: themeFont(s: 12, w: 'm'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Kindly go through the Terms & Conditions of this tournament before registering.',
                        style: themeFont(s: 12, w: 'm'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (widget.tournament.details.pdf != null)
                        ? SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                launchPdfUrl(widget.tournament.details.pdf[1]);
                              },
                              child: Text(
                                'Download Terms & Conditions',
                                style:
                                    themeFont(s: 11, color: kThemeColor, w: 'm')
                                        .copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: double.infinity,
                        height: h * (320 / kScreenH),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (seatsLeft == 0)
                                ? Container(
                                    width: double.infinity,
                                    height: h * (50 / kScreenH),
                                    child: Center(
                                      child: Text(
                                        'Oops! No more room left.',
                                        style: themeFont(s: 14, w: 'sb'),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          topRight: Radius.circular(9)),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: h * (50 / kScreenH),
                                    child: Center(
                                      child: Text(
                                        'Room for just $seatsLeft more teams, HURRY!!',
                                        style: themeFont(s: 14, w: 'sb'),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.4),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          topRight: Radius.circular(9)),
                                    ),
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            DataShower(
                              type: 'Tournament Timeline',
                              data: timeLine,
                            ),
                            SizedBox(
                              height: 5,
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
                                          widget.tournament.main.venue.address
                                              .join(', '),
                                          style: themeFont(s: 13),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'View in ',
                                              style: themeFont(s: 12),
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                'Maps',
                                                style: themeFont(
                                                        s: 12,
                                                        color: kThemeColor)
                                                    .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              onTap: () async {
                                                await launch(mapUrl);
                                              },
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
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Booking Deadline',
                                    style: themeFont(
                                        color: Colors.black.withOpacity(0.7),
                                        s: 13,
                                        w: 'm'),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                      width: w * (0.35),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            deadLine.getDate(),
                                            style: themeFont(s: 13, w: 'm'),
                                          ),
                                          Text(
                                            getSuperScript(
                                                int.parse(deadLine.getDate())),
                                            style: themeFont(s: 7, w: 'm'),
                                          ),
                                          Text(
                                            ' ' + deadLine.getMonth() + ' ',
                                            style: themeFont(s: 13, w: 'm'),
                                          ),
                                          Text(
                                            deadLine.getYear(),
                                            style: themeFont(s: 13, w: 'm'),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
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
                    //===================
                    BlocBuilder<ButtonClickBloc, ButtonClickState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        print(_bloc);
                        if (!(state is ExpandedState)) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: double.infinity,
                              height: 0.27 * h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, offset: Offset(2, 2))
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Prize Pool',
                                      style: themeFont(s: 13, w: 'm'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    height: h * 0.15,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    '${widget.tournament.prizePool[ind.toString()][0]}',
                                                    style: themeFont(
                                                        s: 12, w: 'sb'),
                                                  ),
                                                  Text(
                                                    '₹ ${widget.tournament.prizePool[ind.toString()][1]}',
                                                    style: themeFont(
                                                      s: (ind == 0 ? 20 : 18),
                                                      w: (ind == 0)
                                                          ? 'b'
                                                          : 'sb',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: Image.asset(
                                            'assets/images/player_1_prizepool.png',
                                            fit: BoxFit.cover,
                                          ),
                                          height: h * (130 / kScreenW),
                                          width: w * (130 / kScreenW),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
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
                                              print(_bloc);
                                              _bloc.add(
                                                  TournamentDetailExpanded());
                                            },
                                            child: Text(
                                              'View All Prizes',
                                              style: themeFont(
                                                      color: kThemeColor, s: 10)
                                                  .copyWith(
                                                      decoration:
                                                          TextDecoration.none),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: kThemeColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: double.infinity,
                            height: (0.3 +
                                    (widget.tournament.prizePool.length - 2) *
                                        0.04) *
                                h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(2, 2))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Prize Pool',
                                    style: themeFont(
                                      s: 13,
                                      w: 'm',
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  '${widget.tournament.prizePool[ind.toString()][0]}',
                                                  style:
                                                      themeFont(s: 12, w: 'sb'),
                                                ),
                                                Text(
                                                  '₹ ${widget.tournament.prizePool[ind.toString()][1]}',
                                                  style: themeFont(
                                                    s: (ind == 0 ? 20 : 18),
                                                    w: (ind == 0) ? 'b' : 'sb',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: Image.asset(
                                          'assets/images/player_1.png',
                                          fit: BoxFit.cover,
                                        ),
                                        height: h * (130 / kScreenW),
                                        width: w * (130 / kScreenW),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                separatorBuilder: (_, ind) {
                                                  return SizedBox(
                                                    height: 10,
                                                  );
                                                },
                                                itemCount: widget.tournament
                                                        .prizePool.length -
                                                    2,
                                                itemBuilder: (_, ind) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ' ' +
                                                            widget.tournament
                                                                .prizePool[(ind +
                                                                    2)
                                                                .toString()][0],
                                                        style: themeFont(
                                                          s: 11,
                                                          w: 'sb',
                                                        ),
                                                      ),
                                                      Text(
                                                        ' ₹ ${widget.tournament.prizePool[(ind + 2).toString()][1]}',
                                                        style: themeFont(
                                                            s: 13, w: 'm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                TextButton(
                                                  onPressed: () {
                                                    _bloc.add(
                                                        TournamentDetailExpanded());
                                                  },
                                                  child: Text(
                                                    'View Less',
                                                    style: themeFont(
                                                            color: kThemeColor,
                                                            s: 10)
                                                        .copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_up_sharp,
                                                  color: kThemeColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: double.infinity,
                        height: h * (340 / kScreenH),
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
                              data: '₹ $combinedRegFees',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Players per Team',
                              data: widget.tournament.info.playersPerTeam
                                  .toString(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Substitutes',
                              data: widget.tournament.info.substituteAllowed
                                  .toString(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Type',
                              data: widget.tournament.info.type,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Duration per Match',
                              data:
                                  '${widget.tournament.info.durationPerMatch.toString()} minutes',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Date of Semi-finals',
                              data: semi.printNormal(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Date of Finals',
                              data: finals.printNormal(),
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
                      child: Container(
                        width: double.infinity,
                        height: h * (250 / kScreenH),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                'Contact the Organizer',
                                style: themeFont(s: 16),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.tournament.contact[0].name,
                                  style: themeFont(
                                    w: 'sb',
                                  ),
                                ),
                                SizedBox(
                                  height: vertico,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Call_ContactTheOrganizer.svg',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: horizonto,
                                    ),
                                    Text(
                                      widget.tournament.contact[0].contactNumber
                                          .toString(),
                                      style: themeFont(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: vertico,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Email_ContactTheOrganizer.svg',
                                      height: 15,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: horizonto,
                                    ),
                                    Text(
                                      widget.tournament.contact[0].email
                                          .toString(),
                                      style: themeFont(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.tournament.contact[1].name,
                                  style: themeFont(
                                    w: 'sb',
                                  ),
                                ),
                                SizedBox(
                                  height: vertico,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Call_ContactTheOrganizer.svg',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: horizonto,
                                    ),
                                    Text(
                                      widget.tournament.contact[1].contactNumber
                                          .toString(),
                                      style: themeFont(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: vertico,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Email_ContactTheOrganizer.svg',
                                      height: 15,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: horizonto,
                                    ),
                                    Text(
                                      widget.tournament.contact[1].email
                                          .toString(),
                                      style: themeFont(),
                                    )
                                  ],
                                ),
                              ],
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
        ),
        (clickedOnRegister)
            ? DraggableScrollableSheet(
                builder: (_, ctrl) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(-3, -5)),
                        ]),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    //  height: h * 0.9,
                    child: SingleChildScrollView(
                      controller: ctrl,
                      child: Container(
                        height: h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Terms & Conditions of This Tournament',
                              style: themeFont(w: 'sb')
                                  .copyWith(decoration: TextDecoration.none),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tnc,
                                      style: themeFont().copyWith(
                                          decoration: TextDecoration.none),
                                    ),
                                    Container(
                                      //  color: Colors.red,
                                      height: 500,
                                      width: 500,
                                    )
                                  ],
                                ),
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                minChildSize: 0.5,
                maxChildSize: 1,
                initialChildSize: 0.5,
              )
            : Container(),
        (clickedOnRegister)
            ? Positioned(
                bottom: 10,
                child: Container(
                  width: w,
                  height: 65,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("OK");
                          setState(() {
                            clickedOnRegister = false;
                          });
                        },
                        child: Container(
                          width: w * 0.4,
                          child: ActionButton(
                            bgColor: Colors.white,
                            child: Text(
                              'Cancel',
                              style: themeFont(
                                color: Colors.black,
                              ).copyWith(decoration: TextDecoration.none),
                            ),
                            borderColor: kThemeColor,
                          ),
                        ),
                      ),
                      Container(
                        width: w * 0.4,
                        child: ActionButton(
                          bgColor: kThemeColor,
                          child: Text(
                            'Accept',
                            style: themeFont(
                              color: Colors.white,
                            ).copyWith(decoration: TextDecoration.none),
                          ),
                          onTap: () {
                            setState(() {
                              clickedOnRegister = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TournamentRegisterForm(
                                  currentTour: widget.tournament,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

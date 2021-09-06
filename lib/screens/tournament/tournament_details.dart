import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/button_click/button_click_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/screens/tournament/tournament_register_form.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/data_shower.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

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
  String timeLine;
  String combinedRegFees;
  int minPrice, maxPrice;
  WeirdDateFormat st, en, deadLine, semi, finals;
  bool canRegister;
  ScrollController ctrl;
  bool clickedOnRegister = false;
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
    seatsLeft = 20; // TODO: UPdate it.
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
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    String mapUrl =
        'https://www.google.com/maps/place/${widget.tournament.main.venue.coordinates['latitude']},${widget.tournament.main.venue.coordinates['longitude']}';
    void _launchURL() async => await canLaunch(mapUrl)
        ? await launch(mapUrl)
        : throw 'Could not launch $mapUrl';
    return SafeArea(
      child: Stack(
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
                      if (widget.isReg) {
                        print('Already did');
                      } else if (canRegister == false) {
                        print('deadline finished');
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
                    child: (widget.isReg)
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
                          widget.tournament.details.title,
                          style: themeFont(
                            color: kThemeColor,
                            s: 23,
                            w: 'sb',
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
                        'Kindly go through rules and regulations of the tournament before registering.',
                        style: themeFont(s: 12, w: 'm'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (widget.tournament.details.pdf != null)
                        ? SizedBox(
                            width: double.infinity,
                            child: Text(
                              //TODO: Add download link here. on tap.
                              'Download Rulebook',
                              style:
                                  themeFont(s: 11, color: kThemeColor, w: 'm')
                                      .copyWith(
                                decoration: TextDecoration.underline,
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
                                            TextButton(
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
                                              onPressed: ()async{
                                                await launch(mapUrl);
                                              }

                                              ,
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
                            DataShower(
                              type: 'Category',
                              data: widget.tournament.main.ageRec,
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
                                      'Prize pool',
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
                                              'View all',
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
                                    'Prize pool',
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
                                                    'View less',
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
                        height: h * (320 / kScreenH),
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
                              type: 'Players per team',
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
                              type: 'Duration per match',
                              data:
                                  '${widget.tournament.info.durationPerMatch.toString()} minutes',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Date of Semi-Finals',
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
                  ],
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
                      height: h * 0.5,
                      child: SingleChildScrollView(
                        controller: ctrl,
                        child: Container(
                          height: h * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Terms & Conditions',
                                style: themeFont(
                                  w: 'sb',
                                ).copyWith(decoration: TextDecoration.none),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.tournament.details.term,
                                style: themeFont()
                                    .copyWith(decoration: TextDecoration.none),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  minChildSize: 0.25,
                  maxChildSize: 0.4,
                  initialChildSize: 0.25,
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
      ),
    );
  }
}

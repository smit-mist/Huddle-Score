import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huddle_and_score/blocs/button_click/button_click_bloc.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/models/fifa.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/data_shower.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'fifa_registration_form.dart';

const double vertico = 4, horizonto = 9;

class FifaDetails extends StatefulWidget {
  Fifa fifa;
  bool isReg;
  FifaDetails({this.fifa, this.isReg});

  @override
  _FifaDetailsState createState() => _FifaDetailsState();
}

class _FifaDetailsState extends State<FifaDetails> {
  ButtonClickBloc _bloc;
  bool canRegister;
  DateTime given;
  DateTime today;
  WeirdDateFormat gameDate, deadLine;
  int seatsLeft;
  bool clickedOnRegister = false;
  String mapUrl = "";
  String tnc;
  void precomputer() {
    tnc = "";
    String temp = "";
    for(int i=0;i<widget.fifa.details.terms.length;i++){
      if(widget.fifa.details.terms[i] != '|'){
        temp += widget.fifa.details.terms[i];
      }
      else{
        tnc += temp;tnc += '\n';
        temp = "";
      }
    }
    tnc += temp;
    print('User is registered:- ${widget.isReg}');
    seatsLeft =
        widget.fifa.main.rooms.total - widget.fifa.main.rooms.taken.length;

    gameDate = WeirdDateFormat(date: widget.fifa.main.gameDate);
    deadLine = WeirdDateFormat(
      date: widget.fifa.main.deadLine,
    );

    today = DateTime.now();
    given = DateTime.parse(widget.fifa.main.deadLine);
    canRegister = true;
    if (today.isAfter(given)) {
      canRegister = false;
    }
    mapUrl =
        'https://www.google.com/maps/place/${widget.fifa.main.venue.coordinates['latitude']},${widget.fifa.main.venue.coordinates['longitude']}';
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ButtonClickBloc>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    precomputer();
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
                spreadRadius: 1,
              )
            ]),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
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
                      return;
                    } else if (canRegister == false) {
                      print('deadline finished');
                    } else {
                      setState(() {
                        clickedOnRegister = true;
                      });
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
                          widget.fifa.details.title,
                          //'details',
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
                              'Here is the link\n https://www.huddleandscore.com/fifa/${widget.fifa.fifaId}',
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
                          widget.fifa.poster,
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
                        widget.fifa.details.description,
                        //'details',
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
                              height: 10,
                            ),
                            DataShower(
                              type: 'Game Date',
                              data: gameDate.printNormal(),
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
                                          widget.fifa.main.venue.address
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
                                              onTap: () async {
                                                await launch(mapUrl);
                                              },
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
                              type: 'Booking Deadline',
                              data: deadLine.printNormal(),
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
                    BlocBuilder<ButtonClickBloc, ButtonClickState>(
                      builder: (context, state) {
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
                                                    widget.fifa.prizePool[
                                                        ind.toString()][0],
                                                    //'200',
                                                    style: themeFont(
                                                        s: 12, w: 'sb'),
                                                  ),
                                                  Text(
                                                    widget.fifa.prizePool[
                                                        ind.toString()][1],
                                                    //'hello',
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
                                              _bloc.add(
                                                  TournamentDetailExpanded());
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
                                    (widget.fifa.prizePool.length - 2) * 0.04) *
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
                                                  widget.fifa.prizePool[
                                                      ind.toString()][0],
                                                  style:
                                                      themeFont(s: 12, w: 'sb'),
                                                ),
                                                Text(
                                                  widget.fifa.prizePool[
                                                      ind.toString()][1],
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
                                                separatorBuilder: (_, ind) {
                                                  return SizedBox(
                                                    height: 10,
                                                  );
                                                },
                                                itemCount: widget
                                                        .fifa.prizePool.length -
                                                    2,
                                                itemBuilder: (_, ind) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        widget.fifa.prizePool[
                                                            (ind + 2)
                                                                .toString()][0],
                                                        style: themeFont(
                                                          s: 11,
                                                          w: 'sb',
                                                        ),
                                                      ),
                                                      Text(
                                                        widget.fifa.prizePool[
                                                            (ind + 2)
                                                                .toString()][1],
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
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
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
                        height: h * (190 / kScreenH),
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
                                  style: themeFont(s: 13, w: 'm'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Registration Fee',
                              data:
                                  '₹ ${widget.fifa.info.registrationFee} per head',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Time',
                              data: widget.fifa.info.time,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DataShower(
                              type: 'Mode',
                              data: widget.fifa.info.mode,
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
                                'Contact The Organiser',
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
                                  widget.fifa.contact[0].name,
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
                                      widget.fifa.contact[0].contactNumber
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
                                      widget.fifa.contact[0].email,
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
                                  widget.fifa.contact[1].name,
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
                                      widget.fifa.contact[1].contactNumber
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
                                      widget.fifa.contact[1].email,
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
                  //  height: h * 0.5,
                    child:SingleChildScrollView(
                      controller: ctrl,
                      child: Container(
                        height: h,
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
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(

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
                              height: 65,
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
                                builder: (_) => FifaRegistrationForm(
                                  fifa: widget.fifa,
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

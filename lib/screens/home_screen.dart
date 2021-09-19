import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/repositories/home_repository.dart';
import 'package:huddle_and_score/screens/partner_with_us/partner_with_us_intro.dart';
import 'package:huddle_and_score/screens/tournament/view_all_tournament_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/camera_widget.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import 'fifa/view_all_fifa_screen.dart';

List<String> cities = [
  "Ahmedabad",
  "Jaipur",
  "Chennai",
  "Indore",
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<PermissionStatus> getNotificationsPermission() async {
    return await Permission.notification.request();
  }

  Future<PermissionStatus> getCameraPermission() async {
    return await Permission.camera.request();
  }

  String _chosenValue = "Ahmedabad";
  var _ctrl = CarouselControllerImpl();
  int currPage = 0;
  HomeBloc _bloc;

  bool isValid = false;
  List<String> nameOfBanner = [
    "ad4",
    "ad1",
    "ad2",
    "ad3",
    "ad4",
  ];
  TextEditingController _emailCtrl = TextEditingController();
  bool emailTapped = false;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int current = 0;
    Widget selectCity = StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: h * (450 / kScreenH),
              width: w * (370 / kScreenW),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Ready for the game?',
                    style: themeFont(s: 17, w: 'sb'),
                  ),
                  Text(
                    'Look for best turfs and tournaments in your city!',
                    style: themeFont(s: 12, w: 'm'),
                  ),
                  Container(
                    width: w * (350 / kScreenW),
                    height: h * (200 / kScreenH),
                    child: GridView.builder(
                        itemCount: cities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (101) / (42),
                        ),
                        itemBuilder: (_, int ind) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (ind == 0) current = ind;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    cities[ind],
                                    style: themeFont(
                                        s: 12, w: (ind == 0) ? 'm' : 'r'),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: (current == ind)
                                          ? kThemeColor
                                          : Colors.black),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 42,
                        width: 105,
                        child: ActionButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Proceed',
                            style:
                                themeFont(color: Colors.white, s: 12, w: 'm'),
                          ),
                          bgColor: kThemeColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    List<Widget> indicators = [
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.animateToPage(0,
                duration: Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn);
            currPage = 0;
          });
        },
        isActive: (currPage == 0),
      ),
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.animateToPage(1,
                duration: Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn);

            currPage = 1;
          });
        },
        isActive: (currPage == 1),
      ),
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.animateToPage(2,
                duration: Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn);

            currPage = 2;
          });
        },
        isActive: (currPage == 2),
      ),
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.animateToPage(3,
                duration: Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn);

            currPage = 3;
          });
        },
        isActive: (currPage == 3),
      ),
    ];

    return Container(
      width: w,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Huddle & Score',
                      style: themeFont(color: kThemeColor, s: 26, w: 'sb'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          _chosenValue,
                          style: themeFont(),
                        ),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext _) => selectCity);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                            )),
                      ],
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final status = await getNotificationsPermission();
                    if (status.isGranted) {
                      Fluttertoast.showToast(
                          msg: 'Permission Successfully Granted');
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please grant permission for notifications');
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icons/Bellicon_Home.svg',
                    height: 25,
                    width: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    final status = await getCameraPermission();
                    if (status.isGranted) {
                      var camera = await availableCameras();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CameraApp(
                            cameras: camera,
                          ),
                        ),
                      );
                    } else
                      Fluttertoast.showToast(
                          msg: 'Please grant permission for camera');
                  },
                  child: SvgPicture.asset(
                    'assets/icons/QRScanner_Home.svg',
                    height: 25,
                    width: 25,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: h * (150 / kScreenH),
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: _ctrl,
                    items: [
                      ImageShower(name: nameOfBanner[1]),
                      ImageShower(name: nameOfBanner[2]),
                      ImageShower(name: nameOfBanner[3]),
                      ImageShower(name: nameOfBanner[4]),
                    ],
                    options: CarouselOptions(
                      height: h * (150 / kScreenH),
                      pageSnapping: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      reverse: false,
                      autoPlay: true,
                      onPageChanged: (val, reason) {
                        //   print("Changed $val");
                        setState(() {
                          currPage = val;
                        });
                      },
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 20,
                      width: 50,
                      child: ListView.separated(
                        separatorBuilder: (_, x) {
                          return SizedBox(
                            width: 4,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, ind) {
                          return indicators[ind];
                        },
                        itemCount: indicators.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Upcoming Tournaments',
                  style: themeFont(s: 18, w: 'm'),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewAllTournamentScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: themeFont(s: 13, color: kThemeColor, w: 'm')
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: h * (250 / kScreenH),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Failure) {
                    return Center(
                      child: Text('Failed'),
                    );
                  } else if (state is InitialState) {
                    return Container();
                  }
                  return ListView.separated(
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allTournaments.length,
                      itemBuilder: (_, int index) {
                        return TournamentTile(
                            here: state.allTournaments[index]);
                      });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Upcoming Online Tournaments',
                  style: themeFont(
                    s: 18,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewAllFifaScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: themeFont(s: 13, color: kThemeColor)
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: h * (250 / kScreenH),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Failure) {
                    return Center(
                      child: Text('Failed'),
                    );
                  } else if (state is InitialState) {
                    return Container();
                  }
                  return ListView.separated(
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        width: 20,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: state.allFifa.length,
                    itemBuilder: (_, int index) {
                      return FifaTile(
                        fifa: state.allFifa[index],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Turfs Around You',
              style: themeFont(s: 18, w: 'm'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: h * (442 / kScreenH),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12,
                        ),
                        topRight: Radius.circular(
                          12,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/turf_subs.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: h * (170 / kScreenH),
                    width: double.infinity,
                  ),
                  Text(
                    'COMING SOON',
                    style: themeFont(color: kThemeColor, s: 24, w: 'm'),
                  ),
                  Text(
                    'Be the first one to know when the turfs go live!',
                    style: themeFont(),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      // TODO: Fill color is white only in design.
                      controller: _emailCtrl,
                      decoration:
                          normalTextDecoration('Enter your Email ID').copyWith(
                        errorText: isValid
                            ? 'Please enter a valid email address'
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailCtrl.text)) {
                        setState(() {
                          isValid = true;
                        });
                      } else {
                        setState(() {
                          isValid = false;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoadingScreen()));
                       await HomeRepository()
                            .subscribeTurf(_emailCtrl.text.trim());
                       _emailCtrl.clear();
                       //TODO: Add try catch block in the function..
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: 'Subscribed Successfully');
                      }
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ActionButton(
                        bgColor: kThemeColor,
                        child: Text(
                          'Subscribe',
                          style: themeFont(
                            color: Colors.white,
                          ),
                        ),
                      ),
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
              height: h * (170 / kScreenH),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Partner with us!',
                      style: themeFont(s: 18),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              '• ',
                              style: themeFont(color: kThemeColor, s: 17),
                            ),
                            Text(
                              'List Your Tournament',
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
                              'List Your Turf',
                              style: themeFont(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    //    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ActionButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PartnerWithUsIntro(),
                          ),
                        );
                      },
                      bgColor: kThemeColor,
                      child: Text(
                        'Contact Today',
                        style: themeFont(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageShower extends StatelessWidget {
  String name;
  ImageShower({@required this.name});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: h * (146 / kScreenH),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/$name.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Indicator extends StatefulWidget {
  Function onPressed;
  bool isActive;
  Indicator({this.onPressed, this.isActive});
  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: (widget.isActive ? Colors.white : Colors.grey),
          shape: BoxShape.circle,
        ),
        height: (widget.isActive ? 7 : 5),
        width: (widget.isActive ? 7 : 5),
      ),
    );
  }
}

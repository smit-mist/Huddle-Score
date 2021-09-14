import 'dart:ui';

import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/repositories/home_repository.dart';
import 'package:huddle_and_score/screens/partner_with_us/partner_with_us_intro.dart';
import 'package:huddle_and_score/screens/tournament/view_all_tournament_screen.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/camera_widget.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import 'fifa/view_all_fifa_screen.dart';

List<String> cities = [
  "Ahmedabad",
  "Mumbai",
  "Kolkata",
  "Hyderabad",
  "Lucknow",
  "Noida",
  "Gurugram",
  "Faridabad",
  "Agra",
  "Ajmer"
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
  PageController _ctrl = PageController(initialPage: 1);
  int currPage = 1;
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
  // @override
  // void initState() {
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     setState(() {
  //       if (currPage == 4) {
  //         _ctrl.jumpToPage(0);
  //         _ctrl.nextPage(
  //             duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  //         currPage = 1;
  //       } else {
  //         currPage++;
  //         currPage %= 5;

  //         _ctrl.animateToPage(
  //           currPage,
  //           duration: Duration(milliseconds: 350),
  //           curve: Curves.easeIn,
  //         );
  //       }
  //     });

  //   });
  // }

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
                    'Select Your City',
                    style: themeFont(s: 17, w: 'sb'),
                  ),
                  Text(
                    'so we can look for best turfs and tournaments around you',
                    style: themeFont(s: 12, w: 'm'),
                  ),
                  Container(
                    width: w * (350 / kScreenW),
                    height: h * (230 / kScreenH),
                    child: GridView.builder(
                        itemCount: cities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: (101) / (42),
                        ),
                        itemBuilder: (_, int ind) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (ind == 0) current = ind;
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  cities[ind],
                                  style: themeFont(s: 12).copyWith(
                                    decoration: ind == 0
                                        ? TextDecoration.none
                                        : TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: (current == ind)
                                        ? kThemeColor
                                        : Colors.transparent),
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
            _ctrl.jumpToPage(1);
            currPage = 1;
          });
        },
        isActive: (currPage == 1),
      ),
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.jumpToPage(2);
            currPage = 2;
          });
        },
        isActive: (currPage == 2),
      ),
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.jumpToPage(3);
            currPage = 3;
          });
        },
        isActive: (currPage == 3),
      ),
      Indicator(
        onPressed: () {
          setState(() {
            _ctrl.jumpToPage(4);
            currPage = 4;
          });
        },
        isActive: (currPage == 4),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Container(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please grant permission for notifications');
                    }
                  },
                  child: Icon(
                    Icons.notifications_none,
                    color: kThemeColor,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 5,
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
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: kThemeColor,
                    size: 30,
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
                  PageView(
                    controller: _ctrl,
                    allowImplicitScrolling: true,
                    children: [
                      ImageShower(name: nameOfBanner[4]),
                      ImageShower(name: nameOfBanner[1]),
                      ImageShower(name: nameOfBanner[2]),
                      ImageShower(name: nameOfBanner[3]),
                      ImageShower(name: nameOfBanner[4]),
                    ],
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
              height: h * (225 / kScreenH),
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
                      controller: _emailCtrl,
                      decoration:
                          normalTextDecoration('Enter your Email ID').copyWith(
                        fillColor: Colors.white,
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
                        await HomeRepository().subscribeTurf(_emailCtrl.text);
                        Fluttertoast.showToast(
                            msg: 'You have successfully subscribed');
                        _emailCtrl.clear();
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
      padding: EdgeInsets.symmetric(horizontal: 7),
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
        duration: Duration(milliseconds: 350),
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

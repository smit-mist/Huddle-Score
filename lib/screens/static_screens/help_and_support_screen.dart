import 'package:flutter/material.dart';

import '../../constants.dart';

class HelpAndSupportScreen extends StatefulWidget {
  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  bool ok = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: w,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Help & Support',
                  style: themeFont(color: kThemeColor, s: 23),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Find answers from our support team or get in touch with us via support@huddleandscore.com',
                  style: themeFont(),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'About Huddle & Score',
                  style: themeFont(),
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                  'Huddle & Score is an unparalleled sports booking platform for turfs and tournaments. We are the bridge between the owners and organisers, and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, as well as enter into prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Field extends StatefulWidget {
  String ques, ans;
  Function onPressed;
  bool val;
  Field({this.val, this.ques, this.ans, this.onPressed});
  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      title: Text(
        widget.ques,
        style: themeFont(),
      ),
      trailing: (widget.val == true)
          ? Icon(Icons.keyboard_arrow_up_outlined)
          : Icon(Icons.keyboard_arrow_down_outlined),
      children: [
        Text(
          widget.ans,
          style: themeFont(),
        ),
      ],
      onExpansionChanged: widget.onPressed,
    );
  }
}

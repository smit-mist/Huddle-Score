import 'package:flutter/material.dart';

import '../../constants.dart';
import 'loading_screen.dart';

class BottomBar extends StatelessWidget {
  Function onPressed;
  String actionName;
  BottomBar({this.onPressed,this.actionName});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
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
            onTap: () async {
              await onPressed();
            },
            child: Container(
              height: 40,
              width: w * 0.35,
              child: Center(
                child: Text(
                  actionName,
                  style: themeFont(color: Colors.white,s:15,w:'sb'),
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
    );
  }
}

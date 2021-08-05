import 'package:flutter/material.dart';

Color kThemeColor = Colors.green;

TextStyle themeFont({Color color, FontWeight w}) {
  return TextStyle(color: color, fontWeight: w, fontSize: 14);
}

InputDecoration normalTextDecoration(bool _isActive, String name) {
  return InputDecoration(
    hintText: name,
    contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: (_isActive == false
          ? BorderSide(
              width: 0,
              style: BorderStyle.none,
            )
          : BorderSide(
              width: 2,
              color: kThemeColor,
            )),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: (_isActive == false
          ? BorderSide(
              width: 0,
              style: BorderStyle.none,
            )
          : BorderSide(
              width: 2,
              color: kThemeColor,
            )),
    ),
  );
}

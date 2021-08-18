import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const MaterialColor kThemeColor = const MaterialColor(
  0xff248232,
  const <int, Color>{
    50: const Color(0xff248232),
    100: const Color(0xff248232),
    200: const Color(0xff248232),
    300: const Color(0xff248232),
    400: const Color(0xff248232),
    500: const Color(0xff248232),
    600: const Color(0xff248232),
    700: const Color(0xff248232),
    800: const Color(0xff248232),
    900: const Color(0xff248232),
  },
);
const double kScreenW = 424;
const double kScreenH = 911;
Map<String,FontWeight>convertMe = {
  "Thin":FontWeight.w100,
  "t":FontWeight.w100,
  "l":FontWeight.w300,
  "r":FontWeight.w400,
  "m":FontWeight.w500,
  "sb":FontWeight.w600,
  "b":FontWeight.w700,
  "eb":FontWeight.w800,
};
TextStyle themeFont({Color color, String w, double s}) {
  return TextStyle(
    fontFamily: 'Lexend',
      color: color ?? Colors.black,
      fontWeight: (w == null || convertMe[w] == null) ? FontWeight.w500:convertMe[w],
      fontSize: s ?? 14);
  // return TextStyle(color: color, fontWeight: w, fontSize: 14);
}


InputDecoration normalTextDecoration(String name) {
  return InputDecoration(
    hintText: name,
    hintStyle: themeFont(color: Color(0xff626262), s: 14,w: 'r'),
    contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
    filled: true,
    fillColor: Color(0xFFF1F1F1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        color: kThemeColor,
      ),
    ),

  );
}

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

TextStyle themeFont({Color color, FontWeight w, double s}) {
  return GoogleFonts.lexendDeca(
      color: color ?? Colors.black,
      fontWeight: w ?? FontWeight.normal,
      fontSize: s ?? 14);
  // return TextStyle(color: color, fontWeight: w, fontSize: 14);
}

InputDecoration normalTextDecoration(bool _isActive, String name) {
  return InputDecoration(
    hintText: name,
    hintStyle: themeFont(color: Color(0xff626262), w: FontWeight.normal, s: 14),
    contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
    filled: true,
    fillColor: Colors.grey.withOpacity(
      0.14,
    ),
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

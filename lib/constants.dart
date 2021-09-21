import 'package:flutter/material.dart';

enum formType { Team, Double, Single, noForm }

enum screen { Home, Search, Book, Profile }
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
String getShorter(String s) {
  if (s.length <= 20) return s;
  return s.substring(0, 17) + '...';
}

List<String> teamSports = [
  "cricket",
  "football",
  "basketball",
  "volleyball",
  "hockey",
  "5v5",
  "2v2"
];

formType getFormType(String sport) {
  if (teamSports.contains(sport)) return formType.Team;
  return formType.Single;
}

const double kScreenW = 424;
const double kScreenH = 911;
Map<String, FontWeight> convertMe = {
  "Thin": FontWeight.w100,
  "t": FontWeight.w100,
  "l": FontWeight.w300,
  "r": FontWeight.w400,
  "m": FontWeight.w500,
  "sb": FontWeight.w600,
  "b": FontWeight.w700,
  "eb": FontWeight.w800,
};
TextStyle themeFont({Color color, String w, double s}) {
  return TextStyle(
    fontFamily: 'Lexend',
    color: color ?? Colors.black,
    fontWeight:
        (w == null || convertMe[w] == null) ? FontWeight.w500 : convertMe[w],
    fontSize: s ?? 14,
  );
  // return TextStyle(color: color, fontWeight: w, fontSize: 14);
}

InputDecoration normalTextDecoration(String name) {
  return InputDecoration(
    hintText: name,
    hintStyle: themeFont(color: Color(0xff626262), s: 14, w: 'r'),
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

InputDecoration textFieldDecoration(String name, bool touched) {
  if (!touched)
    return InputDecoration(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintText: name,
      hintStyle: themeFont(color: Color(0xff626262), s: 14, w: 'r'),
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
  else
    return InputDecoration(
      hintText: name,
      hintStyle: themeFont(color: Color(0xff626262), s: 14, w: 'r'),
      contentPadding: EdgeInsets.fromLTRB(13.0, 14.0, 0, 15.0),
      filled: true,
      fillColor: Color(0xFFF1F1F1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: kThemeColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: kThemeColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: kThemeColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: kThemeColor,
        ),
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

Map<int, String> getMonthName = {
  1: "January",
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December'
};

class WeirdDateFormat {
  String date;
  WeirdDateFormat({@required this.date});
  String getDate() {
    return date.substring(8, 10);
  }

  String getMonth() {
    return getMonthName[int.parse(date.substring(5, 7))];
  }

  String getYear() {
    return date.substring(0, 4);
  }

  String printNormal() {
    return getDate() + ' ' + getMonth() + ', ' + getYear();
  }
}

String getSuperScript(int x) {
  x %= 10;
  if (x == 1) return "st";
  if (x == 2) return "nd";
  if (x == 3) return "rd";
  return "th";
}

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h * 0.8,
      color: Colors.red,
    );
  }
}

import 'package:flutter/material.dart';

class NoTourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/no_tour.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

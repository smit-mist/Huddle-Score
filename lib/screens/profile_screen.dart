import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  bool loggedIn;
  ProfileScreen({this.loggedIn});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: double.infinity,
      color: Colors.blue,
    );
  }
}

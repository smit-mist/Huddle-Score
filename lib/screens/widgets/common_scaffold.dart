import 'package:flutter/material.dart';

class CommonScaffold extends StatefulWidget {
  Widget child;
  Widget bottomBar;
  CommonScaffold({this.bottomBar,this.child});
  @override
  _CommonScaffoldState createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: widget.bottomBar,
    );
  }
}

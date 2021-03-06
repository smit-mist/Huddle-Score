import 'package:flutter/material.dart';

import '../../constants.dart';

class ActionButton extends StatefulWidget {
  Widget child;
  Color bgColor;
  Function onTap;
  Color borderColor;
  ActionButton({this.borderColor,this.child, this.bgColor, this.onTap});
  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: (354/kScreenW)*w,
        height: 50,
        child: Center(
          child: widget.child,
        ),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.borderColor?? kThemeColor,
          ),
        ),
      ),
    );
  }
}

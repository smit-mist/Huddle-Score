import 'package:flutter/material.dart';

import '../../constants.dart';

class AboutAppScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: w,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'About',
                style: themeFont(color: kThemeColor, s: 23),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                title: Text('Privacy Policy',style: themeFont(),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Terms and Conditions',style: themeFont(),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

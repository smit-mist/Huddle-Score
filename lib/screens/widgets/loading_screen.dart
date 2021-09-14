import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            height: double.infinity,
            width: double.infinity,
          child: Image.asset('assets/images/loading_final.gif',fit: BoxFit.cover,)
        ),
      ),
    );
  }
}
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset('assets/images/loading_final.gif',fit: BoxFit.cover,),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../constants.dart';

class FifaTile extends StatefulWidget {
  @override
  _FifaTileState createState() => _FifaTileState();
}

class _FifaTileState extends State<FifaTile> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        width: w * (145 / kScreenW),
        height: h * (212 / kScreenH),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    12,
                  ),
                  topRight: Radius.circular(
                    12,
                  ),
                ),
                child: Image.network(
                  'https://picsum.photos/200/300',
                  fit: BoxFit.cover,
                ),
              ),
              height: h * (112 / kScreenH),
              width: w * (145 / kScreenW),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: h*(99/kScreenH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'FIFA championship 2021',
                    style: themeFont(s: 12),
                  ),
                 SizedBox(height: 1,),
                  Text(
                    'Venus, Ahmedabad',
                    style: themeFont(s: 12),
                  ),

                  Text(
                    '11 -12 March, 2021',
                    style: themeFont(s: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/widgets/search_result.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              onChanged: (String x) {
                setState(() {});
              },
              decoration: normalTextDecoration('Tournaments or Locations '),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: w,
              height: h * 0.9,
              child: SearchResult(
                currentSearch: _controller.text,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

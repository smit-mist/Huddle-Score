import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:huddle_and_score/models/home_event.dart';

class HomeRepository {
  Future<List<HomeTour>> fetchTours() async {
    //print("Tournament Fetching started");
    final String baseUrl =
        "https://us-central1-football-demo-3a80e.cloudfunctions.net/openApis/home";
    List<HomeTour> tours = [];
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> docs = jsonDecode(response.body)['tour'];
      //print(docs.runtimeType);
      docs.forEach((key, value) {
        //print(value);
        HomeTour temp = HomeTour.fromJson(key, value, "tour");
        tours.add(temp);
        //print(temp.name);
      });
      return tours;
    } else {
      print('Error!!!! In fetching tournaments');
      return null;
    }

  }

  Future<List<HomeFifa>> fetchFifas() async {
    //print("fifa Fetching started");

    final String baseUrl =
        "https://us-central1-football-demo-3a80e.cloudfunctions.net/openApis/home";
    List<HomeFifa> fifas = [];
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> docs = jsonDecode(response.body)['fifa'];
      print(docs.runtimeType);
      docs.forEach((key, value) {
        //print(value);
        HomeFifa temp = HomeFifa.fromJson(key, value, "fifa");
        fifas.add(temp);
       // print(temp.name);
      });
      return fifas;
    } else {
      print('Error!!!! in fifa fetching');
      return null;
    }
  }
}

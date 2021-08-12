import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:huddle_and_score/models/home_event.dart';

class HomeRepository {
  Future<List<HomeEvent>> fetchTours() async {
    final String baseUrl =
        "https://us-central1-football-demo-3a80e.cloudfunctions.net/openApis/home";
    List<HomeEvent> tours = [];
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> docs = jsonDecode(response.body)['tour'];
      print(docs.runtimeType);
      docs.forEach((key, value) {
        //print(value);
        HomeEvent temp = HomeEvent.fromJson(key, value, "tour");
        tours.add(temp);
        print(temp.name);
      });
      return tours;
    } else {
      print('Error!!!!');
      return null;
    }
  }

  Future<List<HomeEvent>> fetchFifas() async {
    final String baseUrl =
        "https://us-central1-football-demo-3a80e.cloudfunctions.net/openApis/home";
    List<HomeEvent> events = [];
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> docs = jsonDecode(response.body)['fifa'];
      print(docs.runtimeType);
      docs.forEach((key, value) {
        print(value);
        HomeEvent temp = HomeEvent.fromJson(key, value, "fifa");
        events.add(temp);
        print(temp.name);
      });
      return events;
    } else {
      print('Error!!!!');
      return null;
    }
  }
}

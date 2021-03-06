import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:huddle_and_score/models/home_event.dart';

class HomeRepository {
  final String baseUrl =
      "https://asia-south1-huddleandscore-prod.cloudfunctions.net/openApis/home";
  Future<Map<String, List<HomeTour>>> fetchTours() async {
    print("Tournament Fetching started");
    Map<String, List<HomeTour>> toReturn = {};
    List<HomeTour> tours = [];
    var response = await http.get(Uri.parse(baseUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> docs = jsonDecode(response.body)['tour'];
      Map<String, HomeTour> idToTour = {};
      docs.forEach((key, value) {
        HomeTour temp = HomeTour.fromJson(key, value, "tour");
        idToTour[key] = temp;
        tours.add(temp);
      });
      Map<String, dynamic> cityWise = jsonDecode(response.body)['city'];
      cityWise.forEach((key, value) {
        for (var x in value['tour']) {
          if (toReturn[key] == null) toReturn[key] = [];
          toReturn[key].add(idToTour[x.toString()]);
        }
      });
      print("Completed");
      return toReturn;
    } else {
      print('Error!!!! In fetching tournaments');
      return null;
    }
  }

  Future<Map<String, List<HomeFifa>>> fetchFifas() async {
    Map<String, List<HomeFifa>> toReturn = {};
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> docs = jsonDecode(response.body)['fifa'];
      Map<String, HomeFifa> idToFifa = {};
      docs.forEach((key, value) {
        HomeFifa temp = HomeFifa.fromJson(key, value, "fifa");
        idToFifa[key] = temp;
      });
      Map<String, dynamic> cityWise = jsonDecode(response.body)['city'];
      cityWise.forEach((key, value) {
        //
        for (var x in value['fifa']) {
          if (toReturn[key] == null) toReturn[key] = [];
          toReturn[key].add(idToFifa[x.toString()]);
        }
      });
      return toReturn;
    } else {
      print('Error!!!! in fifa fetching');
      return null;
    }
  }

  Future<void> subscribeTurf(String email) async {
    try {
      final String url =
          "https://asia-south1-huddleandscore-prod.cloudfunctions.net/openApis/sub";
      final String jwt = await FirebaseAuth.instance.currentUser.getIdToken();
      var response = await http.post(
        Uri.parse(url),
        headers: {'authorization': 'Bearer $jwt'},
        body: <String, dynamic>{
          'city': '**',
          'email': email,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

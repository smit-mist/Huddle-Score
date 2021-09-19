import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/models/tournament.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

class TournamentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Tournament> getTournamentById(String iD) async {
    try {
      var response = _firestore.doc('tournaments/$iD');
      Tournament tournament = await response.get().then(
            (value) => Tournament.fromMap(
              value.data(),
              value.id,
            ),
          );

      print('complete');
      return tournament;
    } catch (e) {
      print('=============>Failed');
      print(e.toString());
      //return null;
    }
  }

  Future<Record> registerInTournament(Tournament tour, RegDetails data) async {
    print("reg started");
    try {
      final String baseUrl =
          "https://us-central1-football-demo-3a80e.cloudfunctions.net/purchaseApi/tour";
      final String jwt = await AuthRepository().getJwtToken();
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode(<String, dynamic>{
          'tourID': tour.tourId,
          'details': <String, dynamic>{
            'teamName': data.teamName,
            'cap': <String, dynamic>{
              'name': data.captain.fullName,
              'contact': data.captain.contact,
              'age': data.captain.age,
              'email': data.captain.email,
            },
            'viceCaptain': <String, dynamic>{
              'name': data.viceCaptain.fullName,
              'contact': data.viceCaptain.contact,
              'age': data.viceCaptain.age,
              'email': data.viceCaptain.email,
            },
          },
        }),
      );
      print(response.statusCode);
      print(response.body);
      print('khatam');
    } catch (e) {
      print('error in registration');
    }
  }
}

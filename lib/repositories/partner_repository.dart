import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/partner_details.dart';
import 'package:http/http.dart' as http;
import 'package:huddle_and_score/repositories/auth_repository.dart';

class PartnerRepository {
  Future<void> submitPartnerDetails(ParnterDetails details) async {
    try {
      print('before');
      final String baseUrl =
          "https://us-central1-football-demo-3a80e.cloudfunctions.net/openApis/pwu";
      final User user = AuthRepository().getCurrentUser();
      print(user.uid);
      final String jwt = await user.getIdToken();
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode(<String, dynamic>{
          'name': details.name,
          'tourName': details.tourName,
          'tourType': details.tourType,
          'contact': details.contactNumber,
          'email': details.email,
          'city': details.city,
          'type': details.type,
          'state': details.state,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) print('Success=====>>>>');
    } catch (e) {
      print(e.toString());
    }
  }
}

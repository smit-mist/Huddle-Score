import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:huddle_and_score/models/partner_details.dart';

class PartnerRepository {
  Future<void> submitPartnerDetailsForTour(PartnerDetailsTour details) async {
    try {
      final String baseUrl =
          "https://asia-south1-huddleandscore-prod.cloudfunctions.net/openApis/pwu";
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'Application/json'},
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
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> submitPartnerDetailsForTurf(PartnerDetailsTurf details) async {
    try {
      final String baseUrl =
          "https://asia-south1-huddleandscore-prod.cloudfunctions.net/openApis/pwu";
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'Application/json'},
        body: jsonEncode(<String, dynamic>{
          'name': details.name,
          'turfName': details.turfName,
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

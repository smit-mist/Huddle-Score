import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huddle_and_score/models/partner_details.dart';

class PartnerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sendPartnerData(ParnterDetails details) async {
    try {
      var response = await _firestore.doc('config').set({
        details.email: details.convertToMap(),
      });
      print("Succes");
    } catch (e) {
      print("Error $e");
      return ;
    }
  }
}

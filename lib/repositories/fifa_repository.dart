import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huddle_and_score/models/fifa.dart';

class FifaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Fifa> getFifaById(String iD) async {
    try {
   //   print('fifa fetch started');
      var response = _firestore.doc('fifas/$iD');
      Fifa fifa = await response.get().then(
        (value) {
   //       print(value.id);
          return Fifa.fromMap(
            value.data(),
            value.id,
          );
        },
      );
   //   print('fetch started for ${fifa.fifaId}');
     // print('complete');
      return fifa;
    } catch (e) {
      print('====>Failed=====');
      print(e.toString());
    }
  }
}

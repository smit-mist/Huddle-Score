import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huddle_and_score/models/fifa.dart';

class FifaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Fifa> getFifaById(String iD) async {
    var response = _firestore.doc('fifas/$iD');
    // Fifa Fifa = Fifa.fromMap();
    print('before2');
    Fifa fifa = await response.get().then(
          (value) => Fifa.fromMap(
            value.data(),
            value.id,
          ),
        );
    print('after2');
    print("${fifa.fifaId}========>");
    return fifa;
  }
}

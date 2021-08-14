import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huddle_and_score/models/tournament.dart';

class TournamentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Tournament> getTournamentById(String iD) async {
    print('fetching started');
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
}

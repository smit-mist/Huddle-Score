import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huddle_and_score/models/tournaments/tournament.dart';

class TournamentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Tournament>> getTournaments() async {}
}

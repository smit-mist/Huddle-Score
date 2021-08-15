import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> changeUserName(String name) async {
    await _auth.currentUser.updateDisplayName(name);
  }

  Future<void> changeUserEmail(String email) async {
    await _auth.currentUser.updateEmail(email);
  }

  Future<void> changeUserPassword(String password) async {
    await _auth.currentUser.updatePassword(password);
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth _auth;
  AuthRepository() {
    this._auth = FirebaseAuth.instance;
  }

  Future<User> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<User> signUp(String email, String password, String name) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      result.user.updateDisplayName(name);
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    var user = _auth.currentUser;
    return user != null;
  }
}

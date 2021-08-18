import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth _auth;
  AuthRepository() {
    this._auth = FirebaseAuth.instance;
  }

  User getCurrentUser() {
    return _auth.currentUser;
  }

  bool isEmailVerified(){
   return _auth.currentUser.emailVerified;
  }

  Future<void> sendEmailVerificationLink() async {
    final User user = _auth.currentUser;
    await user.sendEmailVerification();
  }

  Future<String> getJwtToken() async {
    final String jwt = await _auth.currentUser.getIdToken();
    return jwt;
  }

  Future<void> updateUserName({String name}) async {
    await _auth.currentUser.updateDisplayName(name);
  }

  Future<void> updateUserEmail({String email}) async {
    await _auth.currentUser.updateEmail(email);
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

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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

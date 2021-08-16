import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/user.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<void> changeUserName(String name) async {
    await _auth.currentUser.updateDisplayName(name);
  }

  Future<void> changeUserEmail(String email) async {
    await _auth.currentUser.updateEmail(email);
  }

  Future<void> changeUserPassword(String password) async {
    await _auth.currentUser.updatePassword(password).then((_) {
    }).catchError((error) {
    });
  }
  Future<UserModel> getBookings()async{
    print('Booking Fetching Started');
    String id =  _auth.currentUser.uid;
    var response = FirebaseFirestore.instance.collection('users/$id/records');


  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

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

  Future<List<BookingDetails>> getBookings() async {
    // print('Booking Fetching Started');
    try {
      String uid = AuthRepository().getCurrentUser().uid;
      var response = FirebaseFirestore.instance.doc('users/$uid/records/tour');
      // ignore: missing_return
      print('in booking fetch');
      var bookingsData = await response.get();
      List<BookingDetails> bookings = [];
      bookingsData.data().forEach((key, value) {
        bookings.add(BookingDetails.fromMap(value));
      });
      return bookings;
    } catch (e) {
      print(e.toString());
    }
  }
}

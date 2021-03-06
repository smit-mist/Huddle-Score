import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
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
    try {
      await _auth.currentUser.updatePassword(password);
    } catch (e) {
      print("Erroorr");
      print(e.toString());
    }
  }

  Future<List<BookingDetails>> getBookings() async {
    print('Booking Fetching Started');

    String uid = AuthRepository().getCurrentUser().uid;
    try {
      var response = FirebaseFirestore.instance.doc('users/$uid/records/tour');
      print('in booking fetch');
      var bookingsData = await response.get();
      print(bookingsData.data());
      List<BookingDetails> bookings = [];
      print("check");
      bookingsData.data().forEach((key, value) {
        print(key);

        bookings.add(BookingDetails.fromMap(value));
      });
      print("Done");
      return bookings;
    } catch (e) {
      print("ERROR");
      print(e.toString());
    }
  }

  Future<List<FifaBookingDetails>> getFifaBookings() async {
    try {
      print('fifa bookings fetch started');

      String uid = AuthRepository().getCurrentUser().uid;
      var response = FirebaseFirestore.instance.doc('users/$uid/records/fifa');
      var bookingsData = await response.get();
      List<FifaBookingDetails> fifaBookings = [];
      bookingsData.data().forEach((key, value) {
        print('key :' + key);
        fifaBookings.add(
          FifaBookingDetails.fromMap(value),
        );
      });
      return fifaBookings;
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }
}

import 'captain.dart';
import 'venue.dart';

class BookingDetails {
  BookingRegDetails regDetails;
  int amount;
  String bookingId;
  TourData data;
  String paymentMethod;
  String recordedAt;
  int taxes;
  String tourId;
  BookingDetails({
    this.amount,
    this.bookingId,
    this.data,
    this.regDetails,
    this.paymentMethod,
    this.recordedAt,
    this.taxes,
    this.tourId,
  });

  factory BookingDetails.fromMap(Map<String, dynamic> doc) => BookingDetails(
        amount: doc['amount'] ?? 37,
        bookingId: doc['bookingID'] ?? "NO booking ID",
        paymentMethod: doc['paymentMethod'] ?? "NO Payment method",
        recordedAt: doc['recordedAt'] ?? 'No time',
        taxes: doc['taxes'] ?? 37,
        tourId: doc['tourID'] ?? "NO ID",
        regDetails: BookingRegDetails.fromMap(doc['RegDetails']),
        data: TourData.fromMap(doc['data']),
      );
}

class TourData {
  String ageRec = 'NULL';
  String poster = 'NOT FOUND';
  List<dynamic> timeLine = ['NOT FOUND'];
  String title;
  String type = "2v2";
  Venue venue;
  TourData({
    this.ageRec = 'NOT FOUND',
    this.poster = 'NOT FOUND',
    this.timeLine = const ['NOT FOUND'],
    this.title = 'NOT FOUND',
    this.venue = const Venue(),
    this.type = "2v2",
  });
  factory TourData.fromMap(Map<String, dynamic> doc) => TourData(
        ageRec: doc['ageRec'] ?? 'NOT FOUND',
        poster: doc['poster'] ?? 'NOT FOUND',
        timeLine: doc['timeLine'] ?? ['NOT FOUND'],
        title: doc['title'] ?? ['NOT FOUND'],
        venue: Venue.fromMap(doc['venue']),
        type: doc['type'] ?? "2v2",
      );
}

class BookingRegDetails {
  final Captain captain;
  final Captain viceCaptain;
  final String teamName;
  const BookingRegDetails({
    this.captain = const Captain(
        fullName: "NULL", email: "NO MAIL", contact: 1212, age: 24),
    this.teamName = "NO Team name",
    this.viceCaptain = const Captain(
        fullName: "NULL", email: "NO MAIL", contact: 1212, age: 24),
  });

  factory BookingRegDetails.fromMap(Map<String, dynamic> doc) =>
      BookingRegDetails(
        captain: Captain.fromMap(doc['p1']),
        teamName: doc['team'],
        viceCaptain: Captain.fromMap(doc['p2']),
      );
}

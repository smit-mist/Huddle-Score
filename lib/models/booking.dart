import 'package:huddle_and_score/models/fifa_record.dart';

class BookingDetails {
  RegDetails regDetails;
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
        amount: doc['amount'],
        bookingId: doc['bookingID'],
        paymentMethod: doc['paymentMethod'],
        recordedAt: doc['recordedAt'],
        taxes: doc['taxes'],
        tourId: doc['tourID'],
        regDetails: RegDetails.fromMap(doc['RegDetails']),
        data: TourData.fromMap(doc['data']),
      );
}

class TourData {
  String ageRec;
  String poster;
  List<dynamic> timeLine;
  String title;
  Venue venue;
  TourData({
    this.ageRec,
    this.poster,
    this.timeLine,
    this.title,
    this.venue,
  });
  factory TourData.fromMap(Map<String, dynamic> doc) => TourData(
        ageRec: doc['ageRec'],
        poster: doc['poster'],
        timeLine: doc['timeLine'],
        title: doc['title'],
        venue: Venue.fromMap(doc['venue']),
      );
}

class Venue {
  List<dynamic> address;
  Map<String, double> coordinates;
  Venue({this.address, this.coordinates});
  factory Venue.fromMap(Map<String, dynamic> map) => Venue(
        address: map['address'].cast<String>(),
        coordinates: map['coordinates'].cast<String, double>(),
      );
}

class RegDetails {
  final Captain captain;
  final Captain viceCaptain;
  final String teamName;
  const RegDetails({
    this.captain =  const Captain(fullName: "NULL",email: "NO MAIL",contact: 1212,age: 24),
    this.teamName = "NO Team name",
    this.viceCaptain = const Captain(fullName: "NULL",email: "NO MAIL",contact: 1212,age: 24),
  });

  factory RegDetails.fromMap(Map<String, dynamic> doc) => RegDetails(
        captain: Captain.fromMap(doc['cap']),
        teamName: doc['teamName'],
        viceCaptain: Captain.fromMap(doc['viceCaptain']),
      );
}

class Captain {
  final int contact;
  final int age;
  final String email;
  final String fullName;
  const Captain({
    this.contact = 373737,
    this.age = 37,
    this.email = "nomail@mail.com",
    this.fullName = "No Name",
  });
  factory Captain.fromMap(Map<String, dynamic> doc) => Captain(
        contact: doc['contact'],
        age: doc['age'],
        email: doc['email'],
        fullName: doc['name'],
      );
}

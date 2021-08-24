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
  Captain captain;
  Captain viceCaptain;
  String teamName;
  RegDetails({
    this.captain,
    this.teamName,
    this.viceCaptain,
  });

  factory RegDetails.fromMap(Map<String, dynamic> doc) => RegDetails(
        captain: Captain.fromMap(doc['cap']),
        teamName: doc['teamName'],
        viceCaptain: Captain.fromMap(doc['viceCaptain']),
      );
}

class Captain {
  int contact;
  int age;
  String email;
  String fullName;
  Captain({
    this.contact,
    this.age,
    this.email,
    this.fullName,
  });
  factory Captain.fromMap(Map<String, dynamic> doc) => Captain(
        contact: doc['contact'],
        age: doc['age'],
        email: doc['email'],
        fullName: doc['name'],
      );
}

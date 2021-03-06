import 'captain.dart';
import 'venue.dart';

class UserModel {
  Map<String, TourBooking> tours;
  Map<String, FifaBooking> fifas;
  UserModel({this.fifas, this.tours});
  factory UserModel.fromMap(
          Map<String, dynamic> data, String tourId, String fifaId) =>
      UserModel(
        tours: {tourId: TourBooking.fromMap(data['tour'])},
        fifas: {fifaId: FifaBooking.fromMap(data['fifa'])},
      );
}

class TourBooking {
  TourRegDetails regDetails;
  int amount;
  String bookingId;
  TourData tourData;
  String tourId;
  int taxes;
  String paymentMethod;
  String recordedAt;
  TourBooking({
    this.amount,
    this.bookingId,
    this.tourId,
    this.tourData,
    this.paymentMethod,
    this.recordedAt,
    this.regDetails,
    this.taxes,
  });
  factory TourBooking.fromMap(Map<String, dynamic> data) => TourBooking(
        regDetails: TourRegDetails.fromMap(data['RegDetails']),
        amount: data['number'],
        bookingId: data['bookingID'],
        tourData: TourData.fromMap(data['data']),
        paymentMethod: data['paymentMethod'],
        recordedAt: data['recordedAt'],
        taxes: data['taxes'],
        tourId: data['tourID'],
      );
}

class FifaBooking {
  FifaRegDetails fifaRegDetails;
  int amount;
  String bookingId;
  FifaData fifaData;
  String fifaId;
  String paymentMethod;
  String recordedAt;
  int taxes;
  FifaBooking({
    this.amount,
    this.bookingId,
    this.fifaData,
    this.fifaId,
    this.fifaRegDetails,
    this.paymentMethod,
    this.recordedAt,
    this.taxes,
  });
  factory FifaBooking.fromMap(Map<String, dynamic> data) => FifaBooking(
        fifaRegDetails: FifaRegDetails.fromMap(data['RegDetails']),
        amount: data['number'],
        bookingId: data['bookingID'],
        fifaData: FifaData.fromMap(data['data']),
        paymentMethod: data['paymentMethod'],
        recordedAt: data['recordedAt'],
        taxes: data['taxes'],
        fifaId: data['fifaID'],
      );
}

class FifaRegDetails {
  int contact;
  String email;
  String fullName;
  String teamName;
  FifaRegDetails({
    this.contact,
    this.email,
    this.fullName,
    this.teamName,
  });
  factory FifaRegDetails.fromMap(Map<String, dynamic> data) => FifaRegDetails(
        contact: data['contact'],
        email: data['email'],
        fullName: data['fullName'],
        teamName: data['teamName'],
      );
}

class FifaData {
  String gameDate;
  String poster;
  String time;
  String title;
  Venue venue;
  FifaData({
    this.gameDate,
    this.poster,
    this.time,
    this.title,
    this.venue,
  });
  factory FifaData.fromMap(Map<String, dynamic> data) => FifaData(
    gameDate: data['gameDate'],
    poster: data['poster'],
    time: data['time'],
    title: data['title'],
    venue: Venue.fromMap(data['venue']),
  );
}

class TourRegDetails {
  Captain captain;
  Captain viceCaptain;
  String teamName;
  TourRegDetails({
    this.captain,
    this.teamName,
    this.viceCaptain,
  });
  factory TourRegDetails.fromMap(Map<String, dynamic> data) => TourRegDetails(
        captain: Captain.fromMap(data['cap']),
        teamName: data['teamName'],
        viceCaptain: Captain.fromMap(data['viceCaptain']),
      );
}

class TourData {
  String ageRec;
  String poster;
  List<String> timeLine;
  String title;
  Venue venue;
  TourData({
    this.ageRec,
    this.poster,
    this.timeLine,
    this.title,
    this.venue,
  });
  factory TourData.fromMap(Map<String, dynamic> data) => TourData(
        ageRec: data['ageRec'],
        poster: data['poster'],
        timeLine: data['timeline'].cast<String>(),
        title: data['title'],
        venue: Venue.fromMap(data['venue']),
      );
}
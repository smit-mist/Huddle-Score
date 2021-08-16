class UserModel {
  Map<String, TourBooking> tours;
  Map<String, FifaBooking> fifas;
  UserModel({this.fifas, this.tours});
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
    this.paymentMethod,
    this.recordedAt,
    this.regDetails,
  });
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
}

class Venue {
  List<String> address;
  Map<String, double> coordinates;
  Venue({this.address, this.coordinates});
  factory Venue.fromMap(Map<String, dynamic> map) => Venue(
        address: map['address'].cast<String>(),
        coordinates: map['coordinates'].cast<String, double>(),
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
}

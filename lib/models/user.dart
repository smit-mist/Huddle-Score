class UserModel {
  Map<String, TourBooking> tours;
  Map<String, FifaBooking> fifas;
  UserModel({this.fifas, this.tours});
  factory UserModel.fromMap(Map<String, dynamic> data, String id) => UserModel(
        tours: {id: TourBooking.fromMap(data['tour'])},
        fifas: data['fifa'],
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
        fifaRegDetails: data['RegDetails'],
        amount: data['number'],
        bookingId: data['bookingID'],
        tourData: data['data'],
        paymentMethod: data['paymentMethod'],
        recordedAt: data['recordedAt'],
        taxes: data['taxes'],
        tourId: data['tourID'],
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
  factory Captain.fromMap(Map<String, dynamic> data) => Captain(
    contact: data['contact'],
    age: data['age'],
    email: data['email'],
    fullName: data['name'],
  );
}

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
  String ageRec = 'NULL';
  String poster = 'NOT FOUND';
  List<dynamic> timeLine = ['NOT FOUND'];
  String title;
  Venue venue;
  TourData({
    this.ageRec = 'NOT FOUND',
    this.poster = 'NOT FOUND',
    this.timeLine = const ['NOT FOUND'],
    this.title = 'NOT FOUND',
    this.venue = const Venue(),
  });
  factory TourData.fromMap(Map<String, dynamic> doc) => TourData(
        ageRec: doc['ageRec'] ?? 'NOT FOUND',
        poster: doc['poster'] ?? 'NOT FOUND',
        timeLine: doc['timeLine'] ?? ['NOT FOUND'],
        title: doc['title'] ?? ['NOT FOUND'],
        venue: Venue.fromMap(doc['venue']),
      );
}

class Venue {
  final List<dynamic> address;
  final Map<String, double> coordinates;
  const Venue(
      {this.address = const ["No address found its null"],
      this.coordinates = const {'latitude': 23.121}});
  factory Venue.fromMap(Map<String, dynamic> map) {
    if (map == null) return Venue();
    return Venue(
      address: map['address'] == null
          ? const ["No add found"]
          : map['address'].cast<String>(),
      coordinates: map['coordinates'] == null
          ? const {'lat': 23.121}
          : map['coordinates'].cast<String, double>(),
    );
  }
}

class RegDetails {
  final Captain captain;
  final Captain viceCaptain;
  final String teamName;
  const RegDetails({
    this.captain = const Captain(
        fullName: "NULL", email: "NO MAIL", contact: 1212, age: 24),
    this.teamName = "NO Team name",
    this.viceCaptain = const Captain(
        fullName: "NULL", email: "NO MAIL", contact: 1212, age: 24),
  });

  factory RegDetails.fromMap(Map<String, dynamic> doc) => RegDetails(
        captain: Captain.fromMap(doc['p1']),
        teamName: doc['teamName']?? 'NOT FOUND',
        viceCaptain:
            doc['p2'] == null ? Captain() : Captain.fromMap(doc['p2']),
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
        contact: doc['contact'] ?? 37,
        age: doc['age'] ?? 37,
        email: doc['email'] ?? 'NOT FOUND',
        fullName: doc['name'] ?? 'NOT FOUND',
      );
}

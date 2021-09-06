class FifaBookingDetails {
  RegDetails regDetails;
  int amount;
  String bookingId;
  FifaData data;
  String paymentMethod;
  String recordedAt;
  int taxes;
  String fifaId;
  FifaBookingDetails({
    this.amount,
    this.bookingId,
    this.data,
    this.regDetails,
    this.paymentMethod,
    this.recordedAt,
    this.taxes,
    this.fifaId,
  });

  factory FifaBookingDetails.fromMap(Map<String, dynamic> doc) =>
      FifaBookingDetails(
        amount: doc['amount'] ?? 37,
        bookingId: doc['bookingID'] ?? "NO booking ID",
        paymentMethod: doc['paymentMethod'] ?? "NO Payment method",
        recordedAt: doc['recordedAt'] ?? 'No time',
        taxes: doc['taxes'] ?? 37,
        fifaId: doc['fifaID'] ?? "NO ID",
        regDetails: RegDetails.fromMap(doc['RegDetails']),
        data: FifaData.fromMap(doc['data']),
      );
}

class FifaData {
  String gameDate = 'NULL';
  String poster = 'NOT FOUND';
  String time = 'NO TIME';
  String title;
  Venue venue;
  FifaData({
    this.gameDate = 'NOT FOUND',
    this.poster = 'NOT FOUND',
    this.time = 'NOT FOUND',
    this.title = 'NOT FOUND',
    this.venue = const Venue(),
  });
  factory FifaData.fromMap(Map<String, dynamic> doc) => FifaData(
        gameDate: doc['gameDate'] ?? 'NOT FOUND',
        poster: doc['poster'] ?? 'NOT FOUND',
        time: doc['time'] ?? 'NOT FOUND',
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
  final String name;
  final String email;
  final int contact;
  final String teamName;
  const RegDetails({
    this.contact = 37,
    this.email = 'NOT FOUND',
    this.name = 'NOT FOUND',
    this.teamName = 'NOT FOUND',
  });

  factory RegDetails.fromMap(Map<String, dynamic> doc) => RegDetails(
        name: doc['fullName']?? 'NOT FOUND',
        email: doc['email']?? 'NOT FOUND',
        contact: doc['contact'] ?? 37,
        teamName: doc['teamName'] ?? 'NOT FOUND',
      );
}

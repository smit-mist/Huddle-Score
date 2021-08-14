import 'package:huddle_and_score/models/record.dart';

class Fifa {
  Map<String, Record> utils; //String is tour id
  Details details;
  String email;
  Info info;
  Main main;
  String orderId;
  String poster;
  Map<String, List<String>> prizePool;
  String fifaId;
  Fifa({
    this.utils,
    this.details,
    this.orderId,
    this.poster,
    this.fifaId,
    this.email,
    this.info,
    this.main,
    this.prizePool,
  });
  factory Fifa.fromMap(Map<String, dynamic> data, String id) => Fifa(
        fifaId: id,
        email: data['email'],
        orderId: data['orderID'],
        prizePool: data['prizePool'].cast<String, List<String>>(),
        main: Main.fromMap(data['main']),
        info: Info.fromMap(data['info']),
        poster: data['poster'],
        details: Details.fromMap(data['details']),
      );
}

class Main {
  String deadLine;
  String gameDate;
  Room rooms;
  Venue venue;
  Main({this.deadLine, this.gameDate, this.rooms, this.venue});
  factory Main.fromMap(Map<String, dynamic> map) => Main(
        deadLine: map['deadLine'],
        gameDate: map['gameDate'],
        rooms: Room.fromMap(map['rooms']),
        venue: Venue.fromMap(map['venue']),
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

class Room {
  List<String> taken;
  int total;
  Room({this.taken, this.total});
  factory Room.fromMap(Map<String, dynamic> map) => Room(
        taken: map['taken'].cast<String>(),
        total: map['total'],
      );
}

class Info {
  String mode;
  String registrationFee;
  String time;
  Info({this.mode, this.registrationFee, this.time});
  factory Info.fromMap(Map<String, dynamic> map) => Info(
    mode: map['mode'],
    registrationFee: map['registrationFee'],
    time: map['time'],
  );
}

class Details {
  String description;
  List<String> pdf;
  String title;
  Details({
    this.description,
    this.pdf,
    this.title,
  });

  factory Details.fromMap(Map<String, dynamic> map) => Details(
        description: map['discription'],
        pdf: map['pdf'].cast<String>(),
        title: map['title'],
      );
}
import 'package:huddle_and_score/models/record.dart';

class Tournament {
  Map<String, Record> utils; //String is tour id
  Details details;
  String email;
  Info info;
  String tourId;
  String orderId;
  Main main;
  Map<String, List<String>> prizePool;
  Tournament({
    this.utils,
    this.details,
    this.tourId,
    this.email,
    this.orderId,
    this.info,
    this.main,
    this.prizePool,
  });

  factory Tournament.fromMap(Map<String, dynamic> data, String id) =>
      Tournament(
        tourId: id,
        email: data['email'],
        orderId: data['orderID'],
        prizePool: data['prizePool'].cast<String,List<String>>(),
        main: Main.fromMap(data['main']),
        info: Info.fromMap(data['info']),
        details: Details.fromMap(data['details']),
      );
}

class Main {
  String ageRec;
  String deadline;
  Room room;
  List<String> timeLine;
  Venue venue;
  Main({this.ageRec, this.deadline, this.room, this.timeLine, this.venue});
  factory Main.fromMap(Map<String, dynamic> map) => Main(
        ageRec: map['ageRec'],
        deadline: map['deadline'],
        timeLine: (map['timeline'] as List).map((e) => e as String).toList(),
        venue: Venue.fromMap(map['venue']),
        room: Room.fromMap(map['rooms']),
      );
}

class Venue {
  List<String> address;
  Map<String, double> coordinates;
  Venue({this.address, this.coordinates});
  factory Venue.fromMap(Map<String, dynamic> map) => Venue(
        address: (map['address'] as List).map((e) => e as String).toList(),
        coordinates: map['coordinates'].cast<String,double>(),
      );
}

class Room {
  List<String> registered;
  int total;
  Room({this.registered, this.total});
  factory Room.fromMap(Map<String, dynamic> map) => Room(
        registered: (map['registered'] as List).map((e) => e as String).toList(),
        total: map['total'],
      );
}

class Info {
  Map<String, String> dates;
  int durationPerMatch;
  int playersPerTeam;
  int registrationFee;
  int substituteAllowed;
  String type;
  Info({
    this.dates,
    this.durationPerMatch,
    this.playersPerTeam,
    this.registrationFee,
    this.substituteAllowed,
    this.type,
  });
  factory Info.fromMap(Map<String, dynamic> map) => Info(
        dates: map['dates'].cast<String,String>(),
        durationPerMatch: map['durationPerMatch'],
        playersPerTeam: map['playersPerTeam'],
        registrationFee: map['registrationFee'],
        substituteAllowed: map['substituteAllowed'],
        type: map['type'],
      );
}

class Details {
  String description;
  List<String> pdf;
  String poster;
  String title;
  Details({
    this.description,
    this.pdf,
    this.poster,
    this.title,
  });
  factory Details.fromMap(Map<String, dynamic> map) => Details(
        description: map['discription'],
        pdf: (map['pdf'] as List).map((e) => e as String).toList(),
        poster: map['poster'],
        title: map['title'],
      );
}
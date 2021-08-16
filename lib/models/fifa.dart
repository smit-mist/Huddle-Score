import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/repositories/fifa_repository.dart';

class Fifa {
  Details details;
  String email;
  Info info;
  Main main;
  String orderId;
  String poster;
  Map<String, List<dynamic>> prizePool;
  String fifaId;
  Fifa({
    this.details,
    this.orderId,
    this.poster,
    this.fifaId,
    this.email,
    this.info,
    this.main,
    this.prizePool,
  });
  factory Fifa.fromMap(Map<String, dynamic> data, String id) {
    print(data['email']);
    print(id);
    print(data['poster']);
    return Fifa(
      fifaId: id,
      email: data['email'],
      orderId: data['orderID'],
      prizePool: data['prizePool'].cast<String, List<dynamic>>(),
      main: Main.fromMap(data['main']),
      info: Info.fromMap(data['info']),
      poster: data['poster'],
      details: Details.fromMap(data['details']),
    );
  }

  Future<Fifa> fromHomeFifa({HomeFifa fifa}) async {
    return await FifaRepository().getFifaById(fifa.fifaId);
  }
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
        registrationFee: map['regestrationFee'].toString(),
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

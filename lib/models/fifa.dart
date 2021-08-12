
import 'package:huddle_and_score/models/record.dart';

class Fifa {
  Map<String, Record> utils; //String is tour id
  Details details;
  String email;
  Info info;
  String tourId;
  Main main;
  Map<int, List<String>> prizePool;
  Fifa({
    this.utils,
    this.details,
    this.tourId,
    this.email,
    this.info,
    this.main,
    this.prizePool,
  });
}

class Main {
  String ageRec;
  String orderId;
  String deadline;
  Room room;
  List<String> timeLine;
  Venue venue;
  Main(
      {this.ageRec,
      this.deadline,
      this.orderId,
      this.room,
      this.timeLine,
      this.venue});
}

class Venue {
  List<String> address;
  Map<String, double> coordinates;
  Venue({this.address, this.coordinates});
}

class Room {
  List<String> registered;
  int total;
  Room({this.registered, this.total});
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
}

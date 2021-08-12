import 'package:huddle_and_score/models/fifas/utils.dart';

class Fifa {
  Utils utils;
  Details details;
  String email;
  Info info;
  String orderId;
  String poster;
  Main main;
  PrizePool prizePool;
  Fifa({
    this.utils,
    this.orderId,
    this.poster,
    this.details,
    this.email,
    this.info,
    this.main,
    this.prizePool,
  });
}

class PrizePool {
  Map<int, List<String>> prizes;
  PrizePool({this.prizes});
}

class Main {
  String deadLine;
  String gameDate;
  Room rooms;
  Venue venue;
  Main({
    this.deadLine,
    this.gameDate,
    this.rooms,
    this.venue,
  });
}

class Venue {
  String address;
  int latitude;
  int longitude;
  Venue({
    this.address,
    this.latitude,
    this.longitude,
  });
}

class Room {
  List<String> taken;
  int total;
  Room({this.taken, this.total});
}

class Info {
  String mode;
  int registrationFee;
  String time;
  Info({
    this.mode,
    this.registrationFee,
    this.time,
  });
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
}

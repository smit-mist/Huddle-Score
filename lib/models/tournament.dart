import 'package:cloud_firestore/cloud_firestore.dart';

class Tournament {
  Details details;
  String email;
  Info info;
  Main main;
  List<PrizePool> prizePool;
  Tournament({
    this.details,
    this.email,
    this.info,
    this.main,
    this.prizePool,
  });

  factory Tournament.mapFromFirestore(DocumentSnapshot doc){
    
  }
}

class PrizePool {
  Map<int, List<String>> prizes;
  PrizePool({this.prizes});
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
  List<String> registered;
  int total;
  Room({this.registered, this.total});
}

class Info {
  Map<String, DateTime> dates;
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

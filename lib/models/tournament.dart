import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/models/record.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/tournaments_repository.dart';

class Tournament {
  Map<String, Record> utils; //String is tour id
  Details details;
  String email;
  Info info;
  String tourId;
  String orderId;
  Main main;
  Map<String, List<dynamic>> prizePool;
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
  bool registeredIn() {
    User value = AuthRepository().getCurrentUser();
    if (value == null) {
      //      print("Not Found");
      return false;
    }
    //  print(this.main.room.registered);
    String id = value.uid;
    for (int i = 0; i < this.main.room.registered.length; i++) {
      //     print(i);
      if (this.main.room.registered[i] == id) {
        print("Found");
        return true;
      }
    }
    print("Not Found");

    return false;
  }

  factory Tournament.fromMap(Map<String, dynamic> data, String id) {
    var ok = Tournament(
      tourId: id,
      email: data['email'] ?? 'Not found',
      orderId: data['orderID'] ?? "NULL",
      prizePool: data['prizePool'] == null
          ? {
              'First': [100]
            }
          : (data['prizePool']).cast<String, List<dynamic>>(),
      main: Main.fromMap(data['main']),
      info: Info.fromMap(data['info']),
      details: Details.fromMap(data['details']),
    );

    return ok;
  }

  Future<Tournament> fromHomeTour(HomeTour tour) async {
    return await TournamentRepository().getTournamentById(tour.tourId);
  }
}

class Main {
  String ageRec;
  String deadline;
  Room room;
  List<String> timeLine;
  Venue venue;
  Main(
      {this.ageRec = 'NULL',
      this.deadline = "NULL",
      this.room = const Room(),
      this.timeLine = const ["NOT FOUND"],
      this.venue = const Venue()});
  factory Main.fromMap(Map<String, dynamic> map) {
    if (map == null) return Main();
    return Main(
      ageRec: map['ageRec'] ?? 'NULL',
      deadline: map['deadline'] ?? 'NULL',
      timeLine: map['timeline'] == null
          ? ["Not found"]
          : map['timeline'].cast<String>(),
      venue: Venue.fromMap(map['venue']),
      room: Room.fromMap(map['rooms']),
    );
  }
}

class Venue {
  final List<String> address;
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

class Room {
  final List<String> registered;
  final int total;
  const Room({this.registered = const ['none'], this.total = 37});
  factory Room.fromMap(Map<String, dynamic> map) {
    if (map == null) return Room();
    return Room(
      registered: map['registered'] == null
          ? ['is null']
          : map['registered'].cast<String>(),
      total: map['total'] ?? 37,
    );
  }
}

class Info {
  final Map<String, String> dates;
  final int durationPerMatch;
  final int playersPerTeam;
  final int registrationFee;
  final int substituteAllowed;
  final String type;
  const Info({
    this.dates = const {'Null': 'NULL'},
    this.durationPerMatch = 37,
    this.playersPerTeam = 37,
    this.registrationFee = 37,
    this.substituteAllowed = 37,
    this.type = "NULL",
  });
  factory Info.fromMap(Map<String, dynamic> map) {
    if (map == null) return Info();
    return Info(
      dates: map['dates'] == null
          ? {'No date': 'Null found'}
          : map['dates'].cast<String, String>(),
      durationPerMatch: map['durationPerMatch'] ?? 37,
      playersPerTeam: map['playersPerTeam'] ?? 37,
      registrationFee: map['regestrationFee'] ?? 37,
      substituteAllowed: map['substituteAllowed'] ?? 37,
      type: map['type'] ?? "NUll",
    );
  }
}

class Details {
  final String description;
  final List<String> pdf;
  final String poster;
  final String title;
  const Details({
    this.description = "NULL",
    this.pdf = const ["NOT FOUND"],
    this.poster = "NULL",
    this.title = 'null',
  });
  factory Details.fromMap(Map<String, dynamic> map) {
    if (map == null) return Details();
    return Details(
      description: map['discription'] ?? 'NULL',
      pdf: (map['pdf'] == null ? ["This is null"] : map['pdf'].cast<String>()),
      poster: map['poster'] ?? 'NULL',
      title: map['title'] ?? 'NULL',
    );
  }
}

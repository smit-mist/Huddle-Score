import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/models/venue.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/fifa_repository.dart';

class Fifa {
  Details details;
  String email;
  Info info;
  Main main;
  String orderId;
  String poster;
  List<ContactDetails> contact;
  Map<String, List<dynamic>> prizePool;
  String fifaId;
  Fifa({
    this.contact,
    this.details,
    this.orderId = 'NULL',
    this.poster = 'NULL',
    this.fifaId = 'NULL',
    this.email = 'Not Found',
    this.info,
    this.main,
    this.prizePool,
  });
  factory Fifa.fromMap(Map<String, dynamic> data, String id) {
    return Fifa(
      contact: contactToList(data['contact']),
      fifaId: id ?? 'NULL',
      email: data['email'] ?? 'NULL',
      orderId: data['orderID'] ?? 'NULL',
      prizePool: (data['prizePool'] == null)
          ? const {
              'NULL': ['NULL']
            }
          : data['prizePool'].cast<String, List<dynamic>>(),
      main: Main.fromMap(data['main']),
      info: Info.fromMap(data['info']),
      poster: data['poster'],
      details: Details.fromMap(data['details']),
    );
  }
  bool registeredIn() {
    User value = AuthRepository().getCurrentUser();
    if (value == null) {
      print("Not Found");
      return false;
    }
    String id = value.uid;

    for (int i = 0; i < this.main.rooms.taken.length; i++) {
      //   print(i);
      if (this.main.rooms.taken[i] == id) {
        //   print("Found");
        return true;
      }
    }
    //print("Not Found");

    return false;
  }

  Future<Fifa> fromHomeFifa({HomeFifa fifa}) async {
    print("here converting to fifa");
    return await FifaRepository().getFifaById(fifa.fifaId);
  }
}
List<ContactDetails> contactToList(Map<String, dynamic> data) {
  List<ContactDetails> res = [];
  data.forEach(
        (key, value) {
      res.add(
        ContactDetails(
          name: value['name'],
          contactNumber: value['num'],
          email: value['email'],
        ),
      );
    },
  );
  return res;
}

class ContactDetails {
  String name, email;
  int contactNumber;
  ContactDetails(
      {this.name = "NOTHING",
        this.email = "NOT MAIL",
        this.contactNumber = 373737373737});
}
class Main {
  String deadLine;
  String gameDate;
  Room rooms;
  Venue venue;
  Main(
      {this.deadLine = 'NULL', this.gameDate = 'NULL', this.rooms, this.venue});
  factory Main.fromMap(Map<String, dynamic> map) => Main(
        deadLine: map['deadLine'] ?? 'NULL',
        gameDate: map['gameDate'] ?? 'NULL',
        rooms: Room.fromMap(map['rooms']),
        venue: Venue.fromMap(map['venue']),
      );
}

class Room {
  List<String> taken;
  int total;
  Room({this.taken, this.total = 37});
  factory Room.fromMap(Map<String, dynamic> map) => Room(
        taken: (map['taken']==null)
            ? const ['NULL']
            : map['taken'].cast<String>(),
        total: map['total'] ?? 37,
      );
}

class Info {
  String mode;
  String registrationFee;
  String time;
  Info({this.mode = 'NULL', this.registrationFee = 'NULL', this.time = 'NULL'});
  factory Info.fromMap(Map<String, dynamic> map) => Info(
        mode: map['mode'] ?? 'NULL',
        registrationFee: map['regestrationFee'].toString() ?? 'NULL',
        time: map['time'] ?? 'NULL',
      );
}

class Details {
  String description;
  List<String> pdf;
  String title;
  String terms;
  Details({
    this.description = 'NULL',
    this.pdf = const ['NULL'],
    this.title = 'NULL',
    this.terms = 'NULL',
  });

  factory Details.fromMap(Map<String, dynamic> map) => Details(
        description: map['discription'] ?? 'NULL',
        pdf: (map['pdf'] == null) ? const ['NULL'] : map['pdf'].cast<String>(),
        title: map['title'] ?? 'NULL',
        terms: map['terms'] ?? 'NULL',
      );
}

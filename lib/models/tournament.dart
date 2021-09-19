import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/models/venue.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/tournaments_repository.dart';

class Tournament {
  List<ContactDetails> contact;
  Details details;
  String email;
  int total;
  Info info;
  String tourId;
  String orderId;
  Main main;
  Map<String, List<dynamic>> prizePool;
  List<Room> rooms;
  int selectedRoom = 0;
  List<dynamic> totalReg;

  Tournament({
    this.total,
    this.contact,
    this.details,
    this.tourId,
    this.email,
    this.rooms,
    this.orderId,
    this.info,
    this.main,
    this.prizePool,
    this.totalReg,
  });
  bool registeredIn() {
    User value = AuthRepository().getCurrentUser();
    if (value == null) {
      return false;
    }
    String id = value.uid;
    for (int i = 0; i < this.totalReg.length; i++) {
      if (this.totalReg[i] == id) {
   //     print("Found");
        return true;
      }
    }
  //  print("Not Registered");
    return false;
  }

  factory Tournament.fromMap(Map<String, dynamic> data, String id) {

    var ok = Tournament(
      tourId: id,
      contact: contactToList(data['contact']),
      email: data['email'] ?? 'Not found',
      orderId: data['orderID'] ?? "NULL",
      prizePool: data['prizePool'] == null
          ? {
              'First': [100]
            }
          : (data['prizePool']).cast<String, List<dynamic>>(),
      main: Main.fromMap(data['main']),
      rooms: toList(data['rooms']),
      info: Info.fromMap(data['info']),
      details: Details.fromMap(data['details']),
      totalReg: data['rooms']['totalReg'],
      total: data['rooms']['total'],
    );
    return ok;
  }
  Future<Tournament> fromHomeTour(HomeTour tour) async {
    return await TournamentRepository().getTournamentById(tour.tourId);
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

List<Room> toList(Map<String, dynamic> data) {
  List<Room> res = [];
  data.forEach(
    (k, v) {
      if (k == 'total' || k == 'totalReg') {
      } else {
        v.forEach((x, y) {
          res.add(Room.fromMap(y, k, x));
        });
      }
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
  String ageRec;
  String deadline;
  List<dynamic> timeLine;
  Venue venue;
  Main(
      {this.ageRec = 'NULL',
      this.deadline = "NULL",
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
    );
  }
}



class Room {
  final List<dynamic> registered;
  final int fees;
  final int maxSeats;
  final String orderId;
  final String category;
  final String subCategory;
  const Room({
    this.registered = const ['none'],
    this.fees = 37,
    this.subCategory,
    this.maxSeats = 37,
    this.orderId = "NOT ORDER ID",
    this.category = "No cater",
  });
  factory Room.fromMap(
      Map<String, dynamic> map, String category, String subCate) {
    if (map == null) return Room();
    return Room(
      registered: map['registered'] == null
          ? ['is null']
          : map['registered'].cast<String>(),
      category: category,
      subCategory: subCate,
      fees: map['fee'],
      orderId: map['orderID'],
      maxSeats: map['max'],
    );
  }
}

class Info {
  final Map<String, String> dates;
  final int durationPerMatch;
  final int playersPerTeam;
  final int substituteAllowed;
  final String type;
  const Info({
    this.dates = const {'Null': 'NULL'},
    this.durationPerMatch = 37,
    this.playersPerTeam = 37,
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
      substituteAllowed: map['substituteAllowed'] ?? 37,
      type: map['type'] ?? "NUll",
    );
  }
}

class Details {
  final String description;
  final List<dynamic> pdf;
  final String poster;
  final String term;
  final String title;
  const Details({
    this.term = "Not term here",
    this.description = "NULL",
    this.pdf = const ["NOT FOUND"],
    this.poster = "NULL",
    this.title = 'null',
  });
  factory Details.fromMap(Map<String, dynamic> map) {
    if (map == null) return Details();
    return Details(
      term: map['terms'] ?? 'Not here',
      description: map['discription'] ?? 'NULL',
      pdf: (map['pdf'] == null ? ["This is null"] : map['pdf'].cast<String>()),
      poster: map['poster'] ?? 'NULL',
      title: map['title'] ?? 'NULL',
    );
  }
}

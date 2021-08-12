import 'package:huddle_and_score/models/users/record.dart';
import 'package:huddle_and_score/models/users/records.dart';

class User {
  String uid;
  Map<String, int> buyIns;
  List<String> favTurf;
  Map<String, int> ratings;
  List<Records> records;
  Booking lastBooking;
  User({
    this.buyIns,
    this.favTurf,
    this.lastBooking,
    this.ratings,
    this.uid,
  });
}

class Booking {
  Data data;
  Record record;
  String type;
}

class Data {
  String gameDate;
  String poster;
  String time;
  String title;
  Data({
    this.gameDate,
    this.poster,
    this.time,
    this.title,
  });
}

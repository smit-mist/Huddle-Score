
import 'package:huddle_and_score/models/record.dart';

class User {
  String uid;
  Map<String, int> buyIns;
  List<String> favTurf;
  Map<String, int> ratings;
  Map<String,Record> records; //String is the id of tour/fifa
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

class HomeEvent {
  String ageRec;
  String tourId;
  List<String> finalsDate;
  String eventType;
  String name;
  String photo;
  HomeRoom room;
  List<String> venue;
  HomeEvent({
    this.ageRec,
    this.eventType,
    this.finalsDate,
    this.name,
    this.photo,
    this.room,
    this.tourId,
    this.venue,
  });

  factory HomeEvent.fromJson(
          String key, Map<String, dynamic> doc, String eventType) =>
      HomeEvent(
        eventType: eventType,
        tourId: key,
        ageRec: doc['ageRec']??'',
        finalsDate: doc['finalsDate'].cast<String>()??[],
        photo: doc['photo'],
        venue: doc['venue'].cast<String>(),
        name: doc['name'],
        room: HomeRoom(
          taken: doc['room']['taken'].cast<String>(),
          total: doc['room']['total'],
        ),
      );
}

class HomeRoom {
  List<String> taken;
  int total;
  HomeRoom({this.taken, this.total});
}

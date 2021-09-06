class Venue {
  final List<dynamic> address;
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

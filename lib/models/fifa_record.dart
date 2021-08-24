class FifaRecord {
  String name, email;
  int number;
  FifaRecord({
    this.email,
    this.name,
    this.number,
  });

  Map<String, dynamic> toMap(FifaRecord record) {
    return <String, dynamic>{
      'contact': record.number,
      'email': record.email,
      'fullName': record.name,
      'teamName': record.name,
    };
  }
}

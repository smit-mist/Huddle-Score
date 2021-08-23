
class Record {
  RegDetails regDetails;
  int amount;
  String bookingId;
  String id;
  String paymentMethod;
  String recordedAt;
  Record({
    this.amount,
    this.bookingId,
    this.id,
    this.paymentMethod,
    this.recordedAt,
    this.regDetails,
  });
}

class RegDetails {
  Captain captain;
  Captain viceCaptain;
  String teamName;
  RegDetails({
    this.captain,
    this.teamName,
    this.viceCaptain,
  });
  Map<String, dynamic> toMap(RegDetails details) {
    return <String, dynamic>{
      'teamName': details.teamName,
      'cap':Captain().toMap(details.captain),
      'viceCaptain':Captain().toMap(details.viceCaptain),
    };
  }
}

class Captain {
  int contact;
  int age;
  String email;
  String fullName;
  Captain({
    this.contact,
    this.age,
    this.email,
    this.fullName,
  });
  Map<String, dynamic> toMap(Captain captain) {
    return <String, dynamic>{
      'contact':captain.contact,
      'age':captain.age,
      'email':captain.email,
      'name':captain.fullName,
    };
  }
}

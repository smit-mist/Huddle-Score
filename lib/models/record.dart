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
}

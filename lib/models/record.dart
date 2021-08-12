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
  String email;
  String fullName;
  String teamName;
  Captain({
    this.contact,
    this.email,
    this.fullName,
    this.teamName,
  });
}

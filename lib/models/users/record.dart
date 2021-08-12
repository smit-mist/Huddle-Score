class Record {
  RegDetails regDetails;
  int amount;
  String bookingId;
  String fifaId;
  String paymentMethod;
  String recordedAt;
  Record({
    this.amount,
    this.bookingId,
    this.fifaId,
    this.paymentMethod,
    this.recordedAt,
    this.regDetails,
  });
}

class RegDetails {
  int contact;
  String email;
  String fullName;
  String teamName;
  RegDetails({
    this.contact,
    this.email,
    this.fullName,
    this.teamName,
  });
}

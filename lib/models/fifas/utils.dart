class Utils {
  List<Team> team;
}

class Team {
  RegTourDetails regTourDetails;
  int amount;
  String bookingId;
  String paymentMethod;
  String recordedAt;
  int taxes = 0;
  Team({
    this.amount,
    this.bookingId,
    this.paymentMethod,
    this.recordedAt,
    this.regTourDetails,
    this.taxes,
  });
}

class RegTourDetails {
  int contact;
  String email;
  String fullName;
  String teamName;
  RegTourDetails({
    this.contact,
    this.email,
    this.fullName,
    this.teamName,
  });
}

class Utils {
  List<Team> team;
  Utils({this.team});
}

class Team {
  RegTourDetails regTourDetails;
  int amount;
  String bookingId;
  String email;
  String paymentMethod;
  String recordedTime;
  Team({
    this.amount,
    this.bookingId,
    this.email,
    this.paymentMethod,
    this.recordedTime,
    this.regTourDetails,
  });
}

class RegTourDetails {
  Captain cap;
  String teamName;
  Captain viceCaptain;
  RegTourDetails({
    this.cap,
    this.teamName,
    this.viceCaptain,
  });
}

class Captain {
  int age;
  int contact;
  String email;
  String name;
  Captain({
    this.age,
    this.contact,
    this.email,
    this.name,
  });
}

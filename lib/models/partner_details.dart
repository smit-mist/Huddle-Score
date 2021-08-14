class ParnterDetails {
  String city, name, tournamentName, state, type, email;
  int contactNumber;
  ParnterDetails({
    this.email,
    this.city,
    this.state,
    this.name,
    this.type,
    this.contactNumber,
    this.tournamentName,
  });
  Map<String, dynamic> convertToMap() {
    return {
      "city": this.city,
      "contact": this.contactNumber,
      "email": this.email,
      "name": this.name,
      "state": this.state,
      "type": this.type,
    };
  }
}

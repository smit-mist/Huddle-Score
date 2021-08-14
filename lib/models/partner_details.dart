class ParnterDetails {
  String city, name, tourName, state, type, email;
  int contactNumber;
  String tourType;
  ParnterDetails({
    this.email,
    this.city,
    this.tourType,
    this.state,
    this.name,
    this.type,
    this.contactNumber,
    this.tourName,
  });
  // Map<String, String> convertToMap() {
  //   return {
  //     "city": this.city,
  //     "contact": this.contactNumber.toString(),
  //     "email": this.email,
  //     "name": this.name,
  //     "state": this.state,
  //     "type": this.type,
  //     "tourType": this.tourType,
  //     "tourName": this.tourName,
  //   };
  //}
}

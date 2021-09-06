
import 'captain.dart';

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
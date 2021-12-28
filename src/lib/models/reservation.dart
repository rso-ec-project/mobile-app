import 'charger.dart';

class Reservation {
  final int id;
  final DateTime from;
  final DateTime to;
  final String code;
  final int userId;
  final int chargerId;
  final int statusId;
  final Charger? charger;

  Reservation(this.id, this.from, this.to, this.code, this.userId, this.chargerId, this.statusId, this.charger);

  factory Reservation.fromJson(Map<String, dynamic> json) {

    Charger? charger;
    if (json['Charger'] == null){
      charger = null;
    }
    else{
      charger = Charger.fromJson(json['Charger']);
    }

    return Reservation(
      json['Id'],
      DateTime.parse(json['From']),
      DateTime.parse(json['To']),
      json['Code'],
      json['UserId'],
      json['ChargerId'],
      json['StatusId'],
      charger
    );
  }
}
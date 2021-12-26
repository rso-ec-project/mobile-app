class ReservationSlot {
  final int chargerId;
  final String chargerName;
  final int duration;
  final DateTime from;
  final DateTime to;

  ReservationSlot(this.chargerId, this.chargerName, this.duration, this.from, this.to);

  factory ReservationSlot.fromJson(Map<String, dynamic> json) {
    return ReservationSlot(
      json['chargerId'],
      json['chargerName'],
      json['duration'],
      DateTime.parse(json['from']),
      DateTime.parse(json['to']),
    );
  }
}
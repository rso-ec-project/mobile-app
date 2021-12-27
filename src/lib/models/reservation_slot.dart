class ReservationSlot {
  final int chargerId;
  final String chargerName;
  final int duration;
  final DateTime from;
  final DateTime to;

  ReservationSlot(this.chargerId, this.chargerName, this.duration, this.from, this.to);

  factory ReservationSlot.fromJson(Map<String, dynamic> json) {
    return ReservationSlot(
      json['ChargerId'],
      json['ChargerName'],
      json['Duration'],
      DateTime.parse(json['From']),
      DateTime.parse(json['To']),
    );
  }
}
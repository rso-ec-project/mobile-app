class ReservationPost {
  final DateTime from;
  final DateTime to;
  final int userId;
  final int chargerId;

  ReservationPost(this.from, this.to, this.userId, this.chargerId);

  Map<String, dynamic> toJson() {
    return {
      "From": from.toIso8601String(),
      "To": to.toIso8601String(),
      "UserId": userId,
      "ChargerId": chargerId,
    };
  }
}
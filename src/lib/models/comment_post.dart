class CommentPost {
  final String content;
  final int rating;
  final int userId;
  final int chargingStationId;

  CommentPost(this.content, this.rating, this.userId, this.chargingStationId);

  Map<String, dynamic> toJson() {
    return {
      "Content": content,
      "Rating": rating,
      "UserId": userId,
      "ChargingStationId": chargingStationId,
    };
  }
}
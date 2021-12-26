class Comment {
  final int id;
  final String content;
  final int rating;
  final DateTime createdAt;
  final int userId;
  final int chargingStationId;

  Comment(this.id, this.content, this.rating, this.createdAt, this.userId, this.chargingStationId);

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['id'],
      json['content'],
      json['rating'],
      DateTime.parse(json['createdAt']),
      json['userId'],
      json['chargingStationId']
    );
  }
}
class Rating {
  final double rating;
  final int totalRatingCount;
  final int rating1Count;
  final int rating2Count;
  final int rating3Count;
  final int rating4Count;
  final int rating5Count;

  Rating(this.rating, this.totalRatingCount, this.rating1Count, this.rating2Count, this.rating3Count, this.rating4Count, this.rating5Count);

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      double.parse(json['rating'].toString()),
      json['totalRatingCount'],
      json['rating1Count'],
      json['rating2Count'],
      json['rating3Count'],
      json['rating4Count'],
      json['rating5Count'],
    );
  }
}
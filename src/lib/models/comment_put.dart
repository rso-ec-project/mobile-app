class CommentPut {
  final String content;
  final int rating;

  CommentPut(this.content, this.rating);

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "rating": rating
    };
  }
}
class News {
  final String title;
  final String url;
  final String source;

  News(this.title, this.url, this.source);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      json['Title'],
      json['Url'],
      json['Source'],
    );
  }
}
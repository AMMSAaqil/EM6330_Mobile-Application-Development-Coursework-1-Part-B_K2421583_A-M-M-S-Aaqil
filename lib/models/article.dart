class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? imageUrl;
  final String? source;

  Article({
    this.title,
    this.description,
    this.url,
    this.imageUrl,
    this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      imageUrl: json['urlToImage'],
      source: json['source']['name'],
    );
  }
}

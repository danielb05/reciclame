class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String content;

  NewsArticle(
      {this.title, this.description, this.urlToImage, this.url, this.content});

  factory NewsArticle.fromJSON(Map<String, dynamic> json) {
    return NewsArticle(
        title: json["title"],
        description: json["description"],
        urlToImage: json["urlToImage"],
        url: json["url"],
        content: json["content"]);
  }
}

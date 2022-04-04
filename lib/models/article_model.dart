
class Article {
  String title;
  String author;
  String source;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  Article({
    required this.title,
    required this.author,
    required this.source,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'source': source,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory Article.fromJson(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      source: map['source']['name'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }
  static Article getArticle() {
    return Article(
      source: 'FXStreet',
      title:
          "Zcash Price Prediction: ZEC eyes \$70 despite crypto market bloodbath",
      author: "John Isige",
      description:
          "Zcash Price Prediction: ZEC eyes \$70 despite crypto market bloodbath",
      url:
          "https://www.fxstreet.com/cryptocurrencies/news/zcash-price-prediction-zec-eyes-70-despite-crypto-market-bloodbath-202010071007",
      urlToImage:
          "https://i0.wp.com/dailyhodl.com/wp-content/uploads/2021/09/altcoins-surge-defiance.jpg?fit=1365%2C800&ssl=1",
      publishedAt: "2020-10-07T10:07:57Z",
      content:
          "Bitcoin has stagnated at the local highs around \$10,700 over the past few hours and days. The leading cryptocurrency remains below the highs it set last week prior to the BitMEX news breaking. Analysts are still optimistic about the cryptocurrency despite the…\nBitcoin has stagnated at the local highs around \$10,700 over the past few hours and days. The leading cryptocurrency remains below the highs it set last week prior to the BitMEX news breaking. Analysts are still optimistic about the cryptocurrency despite the…",
    );
  }
}

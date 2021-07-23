class NewsModel {
  final String title;
  final String body;
  final String image;
  NewsModel({
    required this.title,
    required this.body,
    required this.image,
  });

  factory NewsModel.fromMap(Map map) {
    return NewsModel(
      title: (map['title'] ?? '') as String,
      body: (map['body'] ?? '') as String,
      image: (map['image'] ?? '') as String,
    );
  }
}

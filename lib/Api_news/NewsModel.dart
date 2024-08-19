// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

class Category {
  String title;

  Category({required this.title});
}

class Articles {
  String author;
  String title;
  dynamic description;

  dynamic urlToImage;
  dynamic publishedAt;
  dynamic content;

  Articles({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

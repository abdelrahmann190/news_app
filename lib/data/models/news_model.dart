class News {
  late Map source;
  late dynamic creator;
  late String videoUrl;

  late String title;
  late String description;

  late String url;
  late String? imageUrl;
  late String pubDate;
  late String content;
  late String language;
  late String category;
  late String id;

  News.fromJson(Map<String, dynamic> json) {
    creator = json['creator'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    url = json['link'] ?? '';
    imageUrl = json['image_url'];
    pubDate = json['pubDate'] ?? '';
    content = json['content'] ?? '';
    language = json['language'] ?? '';
    category = json['category'].toString();
    id = json['creator'].toString() + json['pubDate'].toString();
    videoUrl = json['video_url'] ?? '';
  }

  News.fromSnapshot(dynamic document) {
    final data = document.data()!;
    creator = data['creator'];
    title = data['title'];
    description = data['description'] ?? '';
    url = data['url'] ?? '';
    imageUrl = data['image_url'];
    pubDate = data['pubDate'] ?? '';
    language = data['language'] ?? '';
    category = data['category'];
    content = '';
    videoUrl = data['video_url'] ?? '';
    id = data['creator'].toString() + data['pubDate'].toString();
  }
}

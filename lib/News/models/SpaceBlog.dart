import 'dart:convert';

import 'package:exoplanets/News/models/BlogSource.dart';

List<SpaceBlog> spaceNewsFromJson(String str) =>
    List<SpaceBlog>.from(json.decode(str).map((x) => SpaceBlog.fromJson(x)));

class SpaceBlog {
  SpaceBlog({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl = 'lib/assets/images/nullSpace.jpg',
    required this.publishedAt,
    required this.content,
  });
  BlogSource source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? imageUrl;
  String? publishedAt;
  String? content;

  factory SpaceBlog.fromJson(Map<String, dynamic> json) => SpaceBlog(
      source: BlogSource.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      url: json['url'],
      imageUrl: json['urlToImage'],
      content: json['content'],
      description: json['description'],
      publishedAt: json['publishedAt']
  );
}

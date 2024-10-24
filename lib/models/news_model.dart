import 'package:hive/hive.dart';

part 'news_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String subTitle;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String url;

  ArticleModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      subTitle: json['description'] ?? '',
      image: json['urlToImage'],
      url: json['url'],
    );
  }
}

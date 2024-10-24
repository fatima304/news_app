import 'package:dio/dio.dart';
 import 'package:news_app/models/news_model.dart';

class ApiService {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2/',
      receiveDataWhenStatusError: true,
    ),
  );

  Future<List<ArticleModel>> getHeadLines(
      {required Map<String, dynamic> data, required String path}) async {
    try {
      Response response = await dio.get(path, queryParameters: data);
      Map<String, dynamic> newsData = response.data;
      List articles = newsData['articles'];

      List<ArticleModel> articleList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(article);
        articleList.add(articleModel);
      }
      return articleList;
    } catch (e) {
      return [];
    }
  }
}

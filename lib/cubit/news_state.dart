import 'package:news_app/models/news_model.dart';

abstract class NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<ArticleModel> articleModel;

  NewsLoadedState({required this.articleModel});
}

class NewsFailureState extends NewsState {
  final String errorMsg;

  NewsFailureState({required this.errorMsg});
}

class BottomStates extends NewsState{}

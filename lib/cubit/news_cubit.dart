import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_app/constant.dart';
import 'package:news_app/cubit/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NewsCubit extends Cubit<NewsState> {
  ApiService apiService = ApiService();
  int selectedIndex = 0;

  List<String> categories = ['technology', 'business', 'sports'];

  NewsCubit() : super(NewsLoadingState());
  static NewsCubit get(context) => BlocProvider.of(context);

  void onTapScreen(int index) {
    selectedIndex = index;
    getHeadLines(category: categories[selectedIndex]);
    emit(BottomStates());
  }

  Future<void> getHeadLines({required String category}) async {
    emit(NewsLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      var cachedArticles = await loadCachedArticles();
      if (cachedArticles.isNotEmpty) {
        emit(NewsLoadedState(articleModel: cachedArticles));
      } else {
        emit(NewsFailureState(errorMsg: 'No internet and no cached data'));
      }
    } else {
       try {
        List<ArticleModel> articles = await apiService.getHeadLines(
          data: {'category': category, 'apiKey': apiKey},
          path: 'top-headlines',
        );

        log('Fetched articles: ${articles.length}');  

        if (articles.isEmpty) {
          emit(NewsFailureState(errorMsg: 'No articles found'));
        } else {
          await cacheArticles(articles); 
          emit(NewsLoadedState(articleModel: articles));
        }
      } catch (e) {
        log('Error fetching articles: $e');  
        emit(NewsFailureState(errorMsg: 'Failed to load data'));
      }
    }
  }

   Future<void> cacheArticles(List<ArticleModel> articles) async {
    var box = await Hive.openBox('newsBox');
    await box.put('cachedArticles', articles);
  }

  Future<List<ArticleModel>> loadCachedArticles() async {
    var box = await Hive.openBox('newsBox');
    return box.get('cachedArticles', defaultValue: []);
  }
}

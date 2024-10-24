import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

   await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());

   await Hive.openBox<ArticleModel>('articlesBox');

  runApp(
    const NewsApp(),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => NewsCubit(),
        child: const HomePage(),
      ),
    );
  }
}

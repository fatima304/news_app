import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key, required this.articleModel});

  final ArticleModel articleModel;

  Future<void> launchurl() async {
    final Uri uri = Uri.parse(articleModel.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                launchurl();
              },
              child: Image.network(
                articleModel.image ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd2NAjCcjjk7ac57mKCQvgWVTmP0ysxnzQnQ&s',
                // width: double.infinity,
                // height: 200,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              articleModel.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              articleModel.subTitle,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

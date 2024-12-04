import 'package:bolanet76/app/data/article.dart';
import 'package:bolanet76/app/modules/home/controllers/article_detail_controller.dart';
import 'package:bolanet76/app/modules/views/article_detail_webview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  final Article article;
  const ArticleDetailPage({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article.urlToImage ?? article.title,
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text(
                          'No Image',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description ?? "-",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    'Date: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Author: ${article.author}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    article.content ?? "-",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Read more'),
                    onPressed: () {
                      Get.to(() => ArticleDetailWebView(article: article));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

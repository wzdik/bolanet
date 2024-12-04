import 'package:bolanet76/app/data/card_article.dart';
import 'package:bolanet76/app/modules/home/controllers/http_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HttpView extends GetView<HttpController> {
  const HttpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HTTP'),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            // Display a progress indicator while loading
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.secondary),
              ),
            );
          } else {
            // Display the list of articles
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.articles.length,
              itemBuilder: (context, index) {
                var article = controller.articles[index];
                return CardArticle(article: article);
              },
            );
          }
        }));
  }
}

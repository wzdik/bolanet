import 'package:bolanet76/app/data/article.dart';
import 'package:bolanet76/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: article.urlToImage ?? article.title, // Use a fallback tag
          child: SizedBox(
            width: 100,
            height: 100,
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
        ),
        title: Text(article.title),
        subtitle: Text(article.author ?? 'Unknown'),
        onTap: () {
          // Navigasi ke halaman detail artikel
          Get.toNamed(Routes.ARTICLE_DETAILS, arguments: article);
        },
      ),
    );
  }
}

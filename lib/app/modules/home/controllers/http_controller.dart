import 'dart:convert';
import 'package:bolanet76/app/data/article.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HttpController extends GetxController {
  static const String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=31455ce786ed4d1db464cc140d9356ef';

  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final jsonData = response.body;
        final articlesResult = Articles.fromJson(json.decode(jsonData));
        articles.value = articlesResult.articles;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred :$e');
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:bolanet76/app/modules/home/controllers/article_detail_controller.dart';
import 'package:get/get.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}

import 'package:bolanet76/app/modules/home/controllers/http_controller.dart';
import 'package:get/get.dart';

class HttpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpController>(
      () => HttpController(),
    );
  }
}

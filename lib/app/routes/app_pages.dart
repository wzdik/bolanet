// app_pages.dart
import 'package:get/get.dart';
import 'package:bolanet76/app/modules/home/bindings/article_detail_bindings.dart';
import 'package:bolanet76/app/modules/home/bindings/auth_bindings.dart';
import 'package:bolanet76/app/modules/home/bindings/home_binding.dart';
import 'package:bolanet76/app/modules/home/bindings/http_bindings.dart';
import 'package:bolanet76/app/modules/home/views/home_view.dart';
import 'package:bolanet76/app/modules/views/article_detail_view.dart';
import 'package:bolanet76/app/modules/views/article_detail_webview.dart';
import 'package:bolanet76/app/modules/views/discover_screen.dart';
import 'package:bolanet76/app/modules/views/http_view.dart';
import 'package:bolanet76/app/modules/views/login_page.dart';
import 'package:bolanet76/app/modules/views/news_add_page.dart';
import 'package:bolanet76/app/modules/views/news_list_page.dart';
import 'package:bolanet76/app/modules/views/profile.dart';
import 'package:bolanet76/app/modules/views/register_page.dart';
import 'package:bolanet76/app/modules/views/save_screen.dart';
import 'package:bolanet76/app/modules/views/schedule_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.HTTP,
      page: () => const HttpView(),
      binding: HttpBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.ARTICLE_DETAILS,
      page: () => ArticleDetailPage(article: Get.arguments),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: Routes.ARTICLE_DETAILS_WEBVIEW,
      page: () => ArticleDetailWebView(article: Get.arguments),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: Routes.NEWS_LIST,
      page: () => NewsListPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.NEWS_ADD,
      page: () => NewsAddPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.DISCOVER,
      page: () => DiscoverScreen(),
    ),
    GetPage(
      name: Routes.SAVE,
      page: () => SaveScreen(),
    ),
    GetPage(
      name: Routes.SCHEDULE,
      page: () => ScheduleScreen(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileScreen(),
    ),
  ];
}

import 'package:bolanet76/app/modules/services/api_services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NewsSearchController extends GetxController {
  var searchQuery = ''.obs; // Menyimpan kata kunci pencarian
  var searchResults = [].obs; // Menyimpan hasil pencarian
  final ApiService apiService = ApiService(); // Inisialisasi ApiService

  // Fungsi untuk memperbarui kata kunci pencarian
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    performSearch(); // Jalankan fungsi pencarian
  }

  // Fungsi pencarian yang menggunakan API
  void performSearch() async {
    try {
      // Ambil data dari API dan simpan dalam `searchResults`
      final results = await apiService.fetchNews(searchQuery.value);
      searchResults.value = results;
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
}

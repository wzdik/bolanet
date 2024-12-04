import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NewsSearchController extends GetxController {
  var searchQuery = ''.obs;
  var searchResults = [].obs;

  // Update query pencarian
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    searchNews(query); // Panggil fungsi untuk mencari berita
  }

  // Fungsi untuk mencari berita di Firebase berdasarkan query
  void searchNews(String query) async {
    if (query.isEmpty) {
      searchResults.clear(); // Hapus hasil pencarian jika query kosong
      return;
    }

    try {
      // Menggunakan query pencarian
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('news') // Ganti dengan nama koleksi yang sesuai
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Menyimpan hasil pencarian
      searchResults.value = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    } catch (e) {
      print('Error searching news: $e');
    }
  }

  // Fetch data berdasarkan ID dokumen
  Future<void> fetchDataById() async {
    try {
      // Mengambil data berdasarkan ID dokumen yang telah diberikan
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('news') // Ganti dengan koleksi yang sesuai
          .doc('ggbG8MlOSsRUkGFDJaWZ') // Menggunakan ID yang telah diberikan
          .get();

      if (snapshot.exists) {
        var data = snapshot.data();
        print("Document data: $data");
      } else {
        print("No document found");
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}

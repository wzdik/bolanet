import 'dart:convert';

class ApiService {
  final String baseUrl =
      'https://api.soccersapi.com/v2.2/leagues/?user=d4662886&token=8bbc6f83faea7d72f8bd519dbd1cf560&t=list';

  get http => null; // Ganti dengan URL API Anda

  // Fungsi untuk mengambil berita berdasarkan kata kunci
  Future<List<dynamic>> fetchNews(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?query=$query'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print("API Data: $data"); // Debugging: cek data dari API

      return data['articles'] ??
          'bbc6f83faea7d72f8bd519dbd1cf560'; // Sesuaikan dengan struktur respons API Anda
    } else {
      throw Exception("Failed to load news");
    }
  }
}

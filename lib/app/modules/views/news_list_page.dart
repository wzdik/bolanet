import 'package:bolanet76/app/data/news.dart';
import 'package:bolanet76/app/modules/services/news_service.dart';
import 'package:bolanet76/app/modules/views/news_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NewsListPage extends StatelessWidget {
  final NewsService newsService = NewsService();

  NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Berita'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => NewsAddPage());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<News>>(
        future: newsService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada berita.'));
          }

          final newsList = snapshot.data!;

          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return ListTile(
                title: Text(news.title),
                subtitle: Text(news.content),
                onTap: () {
                  // Navigasi ke halaman edit berita (belum dibuat)
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    newsService.deleteNews(news.id).then((_) {
                      Get.snackbar('Berhasil', 'Berita berhasil dihapus');
                    }).catchError((error) {
                      Get.snackbar('Error', 'Gagal menghapus berita: $error');
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

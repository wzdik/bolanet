import 'package:bolanet76/app/data/news.dart';
import 'package:bolanet76/app/modules/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NewsAddPage extends StatelessWidget {
  final NewsService newsService = NewsService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NewsAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Berita')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Konten'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                News news = News(
                  id: '',
                  title: titleController.text,
                  content: contentController.text,
                );
                newsService.addNews(news).then((_) {
                  Get.snackbar('Berhasil', 'Berita berhasil ditambahkan');
                  titleController.clear();
                  contentController.clear();
                }).catchError((error) {
                  Get.snackbar('Error', 'Gagal menambahkan berita: $error');
                });
              },
              child: Text('Tambah Berita'),
            ),
          ],
        ),
      ),
    );
  }
}

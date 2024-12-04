import 'package:bolanet76/app/data/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsService {
  final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');

  Future<void> addNews(News news) async {
    await _newsCollection.add(news.toMap());
  }

  Future<List<News>> getNews() async {
    QuerySnapshot snapshot = await _newsCollection.get();
    return snapshot.docs
        .map((doc) => News.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updateNews(News news) async {
    await _newsCollection.doc(news.id).update(news.toMap());
  }

  Future<void> deleteNews(String id) async {
    await _newsCollection.doc(id).delete();
  }
}

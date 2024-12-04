class News {
  String id;
  String title;
  String content;

  News({required this.id, required this.title, required this.content});

  factory News.fromMap(Map<String, dynamic> data, String documentId) {
    return News(
      id: documentId,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}

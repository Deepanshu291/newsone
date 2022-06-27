class NewsApiModal {
  String title, imageurl, content, description, pageurl,source,publishedAt;

  NewsApiModal(
      {required this.content,
      required this.description,
      required this.imageurl,
      required this.title,
      required this.pageurl,
      required this.source,
      required this.publishedAt
      });

  factory NewsApiModal.fromJson(Map<String, dynamic> jsonData) {
    return NewsApiModal(
        title: jsonData['title']?? "",
        imageurl: jsonData['urlToImage'] ?? "",
        description: jsonData['description'] ?? "",
        content: jsonData['content']?? "",
        pageurl: jsonData['url']?? "",
        source: jsonData['source']['name']?? "",
        publishedAt: jsonData['publishedAt']
        );
  }
}

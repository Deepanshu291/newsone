import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsone/Modal/NewsModal.dart';
import '../env/API_KEY.dart';

Future<List<NewsApiModal>> getData() async {
  Uri uri = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=$API_KEY');
  final res = await http.get(uri);

  if (res.statusCode == 200 || res.statusCode == 201) {
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> article = map['articles'];

    List<NewsApiModal> newsList =
        article.map((jsonData) => NewsApiModal.fromJson(jsonData)).toList();
    return newsList;
    // print(res.body);
  } else {
    // print("error");
    return [];
  }
}

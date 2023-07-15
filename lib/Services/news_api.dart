import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsone/Modal/NewsModal.dart';
import '../env/API_KEY.dart';

Future<List<NewsApiModal>> getData(pageno, category) async {
  // var category = 'business';
  Uri uri;
  // ignore: unnecessary_null_comparison
  if (category != null) {
    uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$API_KEY&page=$pageno');
  } else {
    uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$API_KEY&page=$pageno');
  }

  final res = await http.get(uri);
  print(res.request);
  if (res.statusCode == 200 || res.statusCode == 201) {
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> article = map['articles'];
    List<NewsApiModal> newsList =
        article.map((jsonData) => NewsApiModal.fromJson(jsonData)).toList();
    return newsList;
  } else {
    return [];
  }
}

class NewsApiService {
  Future<List<NewsApiModal>> getData(pageno, category) async {
  // var category = 'business';
  Uri uri;
  // ignore: unnecessary_null_comparison
  if (category != null) {
    uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$API_KEY&page=$pageno');
  } else {
    uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$API_KEY&page=$pageno');
  }

  final res = await http.get(uri);
  print(res.request);
  if (res.statusCode == 200 || res.statusCode == 201) {
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> article = map['articles'];
    List<NewsApiModal> newsList =
        article.map((jsonData) => NewsApiModal.fromJson(jsonData)).toList();
    return newsList;
  } else {
    return [];
  }
}

}

import 'package:flutter/material.dart';
import 'package:newsone/Modal/NewsModal.dart';
import 'package:newsone/Services/news_api.dart';

class NewsApiProvider extends ChangeNotifier {
  final _services = NewsApiService();
  bool isloading = false;
  List<NewsApiModal> _news = [];
  List<NewsApiModal> get news => _news;
  int pageno = 1;
  String category = "";

  Future<void> getAllData() async {
    isloading = true;
    notifyListeners();

    final response = await _services.getData(pageno, category);

    _news = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> loadmore() async {
    pageno += 1;
    notifyListeners();
    await _services.getData(pageno, category).then((value) {
      if (value.isNotEmpty) {
        _news.addAll(value);
        isloading = false;
        notifyListeners();
      } else {
        // isloading = true;
        notifyListeners();
      }
    });
  }

  Future<void> getcategory(category) async {
    this.category = category;
    isloading = true;
    notifyListeners();
    _services.getData(pageno, category).then((value) => {
          if (value.isNotEmpty)
            {_news = value, isloading = false, notifyListeners()}
          else
            {isloading = true, getAllData(), notifyListeners()}
        });
  }

  // getcategory(category) {
  //   getData(pageno, category).then((value) {
  //     setState(() {
  //       if (value.isNotEmpty) {
  //         newslist = value;
  //         isloading = false;
  //       } else {
  //         isloading = true;
  //         getResource();
  //       }
  //     });
  //   });
  // }
}

// ignore: file_names
import 'package:flutter/material.dart';
import 'package:newsone/Modal/NewsModal.dart';
import 'package:newsone/Components/Pageview.dart';
import 'package:newsone/Services/news_api.dart';

// ignore: camel_case_types
class pageview extends StatefulWidget {
  const pageview({Key? key}) : super(key: key);

  @override
  State<pageview> createState() => _pageviewState();
}

// ignore: camel_case_types
class _pageviewState extends State<pageview> {
  List<NewsApiModal> newslist = [];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getResource();
  }

  getResource() {
    getData().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          for (var element in value) {
            if (element.description.isNotEmpty) {
              newslist.add(element);
              isloading = false;
            }
          }
          // print(newslist.length);
        } else {
          isloading = true;
          // print("List is Empty");
          getResource();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: size.height,
            child: PageView.builder(
              itemCount: newslist.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return newslist.last.title.isNotEmpty
                    ? PageViewScreen(
                        news: newslist[index],
                        nextnews: newslist[index + 1].title,
                      )
                    : PageViewScreen(news: newslist[index], nextnews: "None");
              },
            ));
  }
}

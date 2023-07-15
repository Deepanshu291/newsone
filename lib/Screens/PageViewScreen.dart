// ignore: file_names
import 'package:flutter/material.dart';
import 'package:newsone/Components/Pageview.dart';
import 'package:newsone/Providers/ApiProvider.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class pageview extends StatefulWidget {
  const pageview({Key? key}) : super(key: key);

  @override
  State<pageview> createState() => _pageviewState();
}

// ignore: camel_case_types
class _pageviewState extends State<pageview> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<NewsApiProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<NewsApiProvider>(
      builder: (context, value, child) {
        if (value.isloading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final news = value.news;
        return SizedBox(
            height: size.height,
            child: PageView.builder(
              itemCount: news.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return news.last.title.isNotEmpty
                    ? PageViewScreen(
                        news: news[index],
                        nextnews: news[index + 1].title,
                      )
                    : PageViewScreen(news: news[index], nextnews: "None");
              },
            ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newsone/Components/Category.dart';
import 'package:newsone/Components/card.dart';
import 'package:newsone/Modal/Category.dart';
import 'package:newsone/Modal/NewsModal.dart';
import 'package:newsone/Services/news_api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NewsApiModal> newslist = [];
  bool isloading = true;
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  int index = 0;

  

  @override
  void initState() {
    super.initState();
    getResource();
  }

  Future<void> refresh() async {
    // isloading = true;

    await Future.delayed(const Duration(seconds: 2));
    getResource();
  }

  getResource() {
    getData().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newslist = value;
          isloading = false;
        } else {
          isloading = true;
          getResource();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: RefreshIndicator(
          key: refreshkey,
          onRefresh: () => refresh(),
          child: HomeScreen(size: size, isloading: isloading, newslist: newslist)
       
          ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.size,
    required this.isloading,
    required this.newslist,
  }) : super(key: key);

  final Size size;
  final bool isloading;
  final List<NewsApiModal> newslist;

  @override
  Widget build(BuildContext context) {
    return isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
      children: [
        Container(
          color: Colors.transparent,
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoryView(data: category[index],);
            },
          ),
        ),
        // CategoryView(),
        Expanded(
          child: SizedBox(
            height: size.height,
            width: double.infinity,
            child:  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: newslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return PageViewScreen(size: size,);
                      return NewsCard(
                        size: size,
                        news: newslist[index],
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

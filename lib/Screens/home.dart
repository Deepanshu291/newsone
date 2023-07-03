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
  var refreshkey = GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    // isloading = true;
    await Future.delayed(const Duration(seconds: 2));
    // HomeScreen getResource();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
          key: refreshkey,
          onRefresh: () => refresh(),
          child: HomeScreen(
            size: size,
          )),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsApiModal> newslist = [];
  bool isloading = true;
  int index = 0;
  int pageno = 1;
  var nodata = false;
  var categories;
  final scrollcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    getResource();
    // print(scrollcontroller.offset);
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        loadmore();
      }
    });
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  getResource() {
    getData(pageno, categories).then((value) {
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

  Future<void> loadmore() async {
    setState(() {
      pageno += 1;
    });
    await getData(pageno, categories).then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newslist.addAll(value);
          isloading = false;
        } else {
          nodata = true;
        }
      });
    });
  }

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
                    return InkWell(
                      onTap: () => setState(() {
                        categories = category[index].title.toLowerCase();
                        print(categories);
                        newslist.clear();
                        getResource();
                      }),
                      child: CategoryView(
                        data: category[index],
                      ),
                    );
                  },
                ),
              ),
              // CategoryView(),
              Expanded(
                child: SizedBox(
                  height: widget.size.height,
                  width: double.infinity,
                  child: ListView.builder(
                    controller: scrollcontroller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: newslist.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      // return PageViewScreen(size: size,);
                      if (index < newslist.length) {
                        return NewsCard(
                          size: widget.size,
                          news: newslist[index],
                        );
                      } else {
                        if (!nodata) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          );
  }
}

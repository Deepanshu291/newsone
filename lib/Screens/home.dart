import 'package:flutter/material.dart';
import 'package:newsone/Components/Category.dart';
import 'package:newsone/Components/card.dart';
import 'package:newsone/Modal/Category.dart';
import 'package:newsone/Providers/ApiProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  Future<void> refresh(BuildContext context) async {
    var provider = Provider.of<NewsApiProvider>(context, listen: false);
    provider.category = " ";
    provider.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
          key: refreshkey,
          onRefresh: () => refresh(context),
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
  final scrollcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<NewsApiProvider>(context, listen: false);
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        provider.loadmore();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getAllData();
    });
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewsApiProvider>(context, listen: false);
    return Consumer<NewsApiProvider>(
      builder: (context, value, child) {
        if (value.isloading) {
          return const Center(child: CircularProgressIndicator());
        }
        final news = value.news;
        return Column(
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
                      var categories = category[index].title.toLowerCase();
                      provider.getcategory(categories);
                      print(categories);
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
                  itemCount: news.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    // return PageViewScreen(size: size,);
                    if (index < news.length) {
                      return NewsCard(
                        size: widget.size,
                        news: news[index],
                      );
                    } else {
                      if (!news.isEmpty) {
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
      },
    );
  }
}

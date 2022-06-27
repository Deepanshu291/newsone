

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsone/Modal/NewsModal.dart';
import 'package:newsone/Screens/WebViewScreen.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class NewsCard extends StatefulWidget {
  NewsApiModal news;
  String img = 'https://www.mtu.edu.np/images/noimg.png';
  NewsCard({Key? key, required this.size, required this.news})
      : super(key: key);

  final Size size;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late var duration =
      DateTime.now().difference(DateTime.parse(widget.news.publishedAt));
  late String time = (duration.inHours >= 1)
      ? "${duration.inHours} Hour ago"
      : "${duration.inHours} Minutes Ago";

  @override
  Widget build(BuildContext context) {
    return widget.news.description.isNotEmpty
        ? GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebScreen(news: widget.news),)),
          child: Container(
              padding:const EdgeInsets.all(10),
              width: widget.size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Card(
                elevation: 10,
                shadowColor: Colors.deepPurple.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  // side: BorderSide(color: Colors.white70, width: 0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    // color: Colors.deepPurpleAccent,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.deepPurpleAccent.shade700,
                          Colors.purple.shade900
                        ]
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          imageUrl: widget.news.imageurl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                             const Icon(Icons.error),
                        ),
                        Container(
                          padding:const EdgeInsets.only(left: 20,top: 10,right: 20),
                          child: Text(
                            widget.news.title,
                            maxLines: 2,
                            style:const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          padding:const EdgeInsets.only(left: 20,top: 10,right: 20),
                          child: Text(
                            // " description"
                            widget.news.description,
                            maxLines: 4,
                            style:const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                       const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding:const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding:const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    // " Source",
                                    widget.news.source,
                                    style:const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      time,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    IconButton(
                                    onPressed: () => Share.share(widget.news.pageurl,subject: 'Look what i know from NewsOne App',),
                                    icon: const Icon(Icons.share_outlined,color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        )
        : Container();
  }
}

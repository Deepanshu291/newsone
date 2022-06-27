// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsone/Modal/NewsModal.dart';
import 'package:newsone/Screens/WebViewScreen.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class PageViewScreen extends StatefulWidget {
  NewsApiModal news;
  String nextnews;
  PageViewScreen({Key? key, required this.news,required this.nextnews}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  late var duration =
      DateTime.now().difference(DateTime.parse(widget.news.publishedAt));
  late String time = (duration.inHours >= 1)
      ? "${duration.inHours} Hour ago"
      : "${duration.inHours} Minutes Ago";
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return (widget.news.description.isNotEmpty)
        ? GestureDetector(
            // onTap: ,
            onHorizontalDragStart: (details) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebScreen(news: widget.news),)),
            child: Hero(
              tag: widget.news,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    // color: Colors.deepPurpleAccent,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.deepPurpleAccent.shade700,
                          Colors.blueAccent.shade700
                        ]
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                          imageUrl: widget.news.imageurl,
                          // "https://images.indianexpress.com/2022/06/WhatsApp-Express-Photo-1-2.jpg",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          child: Text(
                            widget.news.title,
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
                              child: SingleChildScrollView(
                                child: Text(
                                  // " description"
                                  widget.news.description,
                                  // maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 2,
                          color: Colors.white,
                          // width: double.infinity,
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                 horizontal: 20),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // " Source",
                                  widget.news.source,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
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
                            Container(
                              // height: 20,
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black38
                              ),
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: size.width*0.75,
                                      child:Text(widget.nextnews,maxLines: 2, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),

                                  ),
                                  const Icon(Icons.arrow_right_alt_outlined,color: Colors.white),
                                  
                                 
                                ],
                              ),
                            )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : CachedNetworkImage(
          imageUrl:
              "https://cdn-icons-png.flaticon.com/512/1801/1801044.png",
          fit: BoxFit.cover,
        );
  }
}
// class PageViewScreen extends StatefulWidget {
//   PageViewScreen({Key? key}) : super(key: key);

//   @override
//   State<PageView> createState() => _PageViewState();
// }

// class _PageViewState extends State<PageView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500,
//       child: Center(
//         child: Text("Title"),
//       ),
//     );
//     // 
//   }
// }

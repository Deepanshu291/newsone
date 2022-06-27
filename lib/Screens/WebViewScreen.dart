// ignore: file_names
import 'package:flutter/material.dart';
import 'package:newsone/Modal/NewsModal.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebScreen extends StatefulWidget {
  NewsApiModal news;
  WebScreen({Key? key, required this.news}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 2,
        title: Text(widget.news.source),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.share))],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            color: Colors.deepPurpleAccent,
            value: progress,
          ),
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.news.pageurl,
              onProgress: (progress) => setState(() {
                this.progress = progress/100;
              }),
            ),
          ),
        ],
      ),
    );
  }
}

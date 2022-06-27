import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../Modal/Category.dart';

class CategoryView extends StatelessWidget {
  Category data;
  CategoryView({Key? key , required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              imageUrl: data.imageurl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.black38),
            child: Text(
              data.title,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

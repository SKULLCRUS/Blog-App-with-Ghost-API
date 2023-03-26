// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:medlr_blog/utils/time_utils.dart';

class BlogTile2 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String id;
  final String authorName;
  final String authorImageUrl;
  final DateTime publishedAt;

  // const BlogTile2({super.key});
  BlogTile2({
    // Key? key,
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.publishedAt,
    required this.authorName,
    required this.authorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(24))),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Hero(
                tag: id,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 4),
            width: MediaQuery.of(context).size.width,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              authorImageUrl == ''
                  ? Icon(Icons.person)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.network(
                            '$authorImageUrl',
                            fit: BoxFit.cover,
                          ))),
              SizedBox(
                width: 5,
              ),
              Text(authorName),
              SizedBox(
                width: 5,
              ),
              Icon(size: 10, color: Colors.grey[500], Icons.circle_rounded),
              SizedBox(
                width: 5,
              ),
              Text(prettyTimeStamp(publishedAt)),
              // Text('$readTime min'),
            ]),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

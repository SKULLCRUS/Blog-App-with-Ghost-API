import 'package:flutter/material.dart';
import 'package:ghost/ghost.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../utils/time_utils.dart';

class BlogPage extends StatefulWidget {
  final GhostPost data;
  // final String id;
  const BlogPage({
    super.key,
    required this.data,
    // required this.id,
  });

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 233, 233),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    widget.data.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.person),
                    // widget.data.authors![0].profileImage == ''
                    //     ? Icon(Icons.person)
                    //     : ClipRRect(
                    //         borderRadius: BorderRadius.circular(25),
                    //         child: Container(
                    //             height: 20,
                    //             width: 20,
                    //             child: Image.network(
                    //               '${widget.data.authors![0].profileImage}',
                    //               fit: BoxFit.cover,
                    //             ))),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.data.authors![0].name!),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                        size: 10,
                        color: Colors.grey[500],
                        Icons.circle_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text(prettyTimeStamp(widget.data.publishedAt!)),
                  ]),
                ],
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              // Text(widget.data.excerpt!),
              // SizedBox(
              //   height: 10,
              // ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Hero(
                    tag: widget.data.id.toString(),
                    child: Image.network(widget.data.featureImage!)),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: WebViewPlus(
                    javascriptChannels: null,
                    onWebViewCreated: (controller) {
                      controller.loadString("""
             <!DOCTYPE html>
                    <html lang="en">
                    <head>
              <meta charset="UTF-8">
              <meta http-equiv="X-UA-Compatible" content="IE=edge">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>Document</title>
                    </head>
                    <body>
                  '${widget.data.html}'
             </body>
                    </html>
            """);
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
              ),
              // Text(widget.data.plaintext!),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  // BlogTile({super.key});
  late final String title;
  final String imageUrl;
  BlogTile({required this.title, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: Container(
        height: 200,
        width: 328,
        margin: EdgeInsets.all(2),
        decoration: const BoxDecoration(
            color: Colors.white,
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   // stops: [0.1, 0.5, 0.7, 0.9],
            //   colors: [
            //     Color.fromARGB(101, 231, 183, 199),
            //     Color.fromARGB(120, 70, 202, 204),
            //   ],
            // ),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 114,
                width: 114,
                // margin: EdgeInsets.all(17),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Image(
                  // image: AssetImage('assets/images/Med.png'),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 16 / 1.2,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      maxLines: 4,
                      title,
                      // softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      // overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Date"),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Reading Time"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

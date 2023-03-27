import 'package:flutter/material.dart';
import 'package:ghost/ghost.dart';
import 'package:http/http.dart' as http;
import 'package:medlr_blog/screens/blog_page.dart';
import 'package:medlr_blog/utils/time_utils.dart';
import '../widgets/blog_tile_widget2.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = TextEditingController();
  final searchnode = FocusNode();

  Future<List<GhostPost>> fetch_data() async {
    final api = GhostContentAPI(
      url: 'https://demo.ghost.io',
      key: '22444f78447824223cefc48062',
      version: 'v3',
    );
    prettyTimeStamp(DateTime.now());
    return await api.posts.browse(
        limit: 10,
        include: ['tags', 'authors'],
        formats: ['html', 'plaintext']);

    // print(object)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 169, 169),
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        //Search box!
        Row(
          children: [
            Padding(
              //Search Box*******************************
              padding: const EdgeInsets.only(left: 10.5, right: 110),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 60,
                  width: 200,
                  child: TextFormField(
                    controller: controller,
                    onChanged: (_) {
                      // fetch_data();
                    },
                    focusNode: searchnode,
                    onEditingComplete: () {
                      searchnode.unfocus();
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Discover!',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                        // suffixIcon: IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.mic),
                        // ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(24),
                        )),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            // Text('Hello'),
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      './assets/images/user_pic.jpg',
                      fit: BoxFit.cover,
                    )))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            // margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder(
              future: fetch_data(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<GhostPost>> snapshot) {
                if (snapshot.data == null) {
                  return Text('Loading...');
                } else {
                  return ListView.builder(
                    physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (_, __, ___) => BlogPage(
                                      data: snapshot.data![index],
                                    )),
                          );
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => BlogPage(
                          //           data: snapshot.data![index],
                          //           // id: snapshot.data![index].id,
                          //         )));
                        },
                        child: BlogTile2(
                          title: snapshot.data![index].title!,
                          imageUrl: snapshot.data![index].featureImage!,
                          publishedAt: snapshot.data![index].publishedAt!,
                          id: snapshot.data![index].id!,
                          authorName: snapshot.data![index].authors![0].name!,
                          authorImageUrl:
                              snapshot.data![index].authors![0].profileImage ??
                                  '',
                          // readTime: 0,
                        ),
                      );
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  );
                }

                // Build your UI
              },
            ),
          ),
        )
      ]),
    );
  }
}

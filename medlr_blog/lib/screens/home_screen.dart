import 'package:flutter/material.dart';
import 'package:medlr_blog/widgets/blog_tile_widget.dart';
import 'package:ghost/ghost.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = TextEditingController();
  final searchnode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    searchnode.dispose();
    super.dispose();
  }

  Future<List<GhostPost>> fetch_data() async {
    final api = GhostContentAPI(
      url: 'https://medlr.in/blog',
      key: '31b7aefc87a22661d0af42fe77',
      version: 'v3',
    );

    return await api.posts.browse(
      limit: 10,
      include: ['tags', 'authors'],
    );
    // print(object)
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (() {
                      _scaffoldKey.currentState?.openDrawer();
                    }),
                    icon: const ImageIcon(
                        AssetImage('assets/images/Drawer icon.png')),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color.fromARGB(255, 255, 190, 136),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              //Search Box*******************************
              padding: const EdgeInsets.only(left: 30.5, right: 30.5),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: controller,
                    onChanged: (_) {
                      fetch_data();
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.5, right: 10.5),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      // color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FutureBuilder(
                    future: fetch_data(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<GhostPost>> snapshot) {
                      if (snapshot.data == null) {
                        return Text('no blogs to show');
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return BlogTile(
                              title: snapshot.data![index].title!,
                              imageUrl: snapshot.data![index].featureImage!,
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      }

                      // Build your UI
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

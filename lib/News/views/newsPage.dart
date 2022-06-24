import 'package:exoplanets/Game/views/MainMenu.dart';
import 'package:exoplanets/News/models/SpaceBlog.dart';
import 'package:exoplanets/News/services/RemoteService.dart';
import 'package:exoplanets/News/views/NewsCard.dart';
import 'package:exoplanets/PlanetList/views/PlanetListPage.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<SpaceBlog>? blogs;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    print("getting news");
    blogs = await RemoteService().getData();
    if (blogs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void makeNavigation(int index) async {
    switch (index) {
      case 0:
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainMenu(),
            ));
        break;
      case 1:
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanetListPage(),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/space.jpg'),
                  fit: BoxFit.cover)),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                      'NEWS',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 32),
                    ),
                  );
                }
                index -= 1;
                return NewsCard(blogs: blogs, index: index);
              }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: BottomNavigationBar(
              backgroundColor: Colors.white12,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              unselectedFontSize: 20,
              selectedFontSize: 20,
              onTap: (int index) => makeNavigation(index),
              items: [
                BottomNavigationBarItem(icon: Image.asset('assets/images/triangle.png', scale: 12,), label: "Game"),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/circle.png', scale: 12,), label: "Discoveries"),
              ],
            ),
          ),
        ),
      ),
      replacement: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(
            color: Color(0xff5c56c1),
          ),
        ),
      ),
    );
  }
}

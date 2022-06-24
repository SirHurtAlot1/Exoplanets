import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPage extends StatelessWidget {
  final String? image;
  final String? title;
  final String? body;
  final String? url;
  final String? sourceName;
  const BlogPage(
      {Key? key,
      required this.image,
      required this.title,
      required this.body,
      required this.url,
      required this.sourceName});

  void goToUrl(String url) async {
    if (!await launch(url)) throw 'Could not open!!!!!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/space.jpg'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    this.title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffa5aecf),
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffa5aecf), width: 3),
                        borderRadius: BorderRadius.circular(20),

                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                          width: 410,
                          height: 245,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/nullSpace.jpg'),
                          imageUrl: this.image!),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  this.body!,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xffa5aecf),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    goToUrl(this.url!);
                  },
                  child: Text(
                    'Read more on ${this.sourceName}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

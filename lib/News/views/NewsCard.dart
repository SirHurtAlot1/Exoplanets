import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exoplanets/News/views/BlogPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/SpaceBlog.dart';

class NewsCard extends StatelessWidget {
  final List<SpaceBlog>? blogs;
  final int index;
  const NewsCard({Key? key, required this.blogs, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlurryContainer(
        color: Colors.white12,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                    width: 410,
                    height: 245,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/nullSpace.jpg'),
                    imageUrl: blogs![index].imageUrl!),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  blogs![index].title!,
                  style: TextStyle(
                      color: Color(0xffa5aecf), fontWeight: FontWeight.w600),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlogPage(
                                image: blogs![index].imageUrl!,
                                title: blogs![index].title!,
                                body: blogs![index].content!,
                                url: blogs![index].url!,
                                sourceName: blogs![index].source.name,
                              ))),
                  child: Text(
                    'Check it',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

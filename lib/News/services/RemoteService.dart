import 'dart:convert';
import 'package:exoplanets/News/models/SpaceBlog.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  final endpoint = 'newsapi.org';
  var client = http.Client();
  Future<List<SpaceBlog>?> getData() async {
    final uri = Uri.parse('https://newsapi.org/v2/everything?q=exoplanet&apiKey=1d321798fb914380b69049c102e5d20c');
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<SpaceBlog> blogs = body.map((dynamic item)=>SpaceBlog.fromJson(item)).toList();
    return blogs;

  }
}

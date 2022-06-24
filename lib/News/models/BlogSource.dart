

class BlogSource{
  String? id;
  String name;

  BlogSource({this.id, required this.name});


  factory BlogSource.fromJson(Map<String, dynamic> json){
    return BlogSource(id: json['id'], name: json['name']);
  }
}
import 'dart:convert';

class Book {
  Book({
    this.title,
    this.description,
    this.url,
  });
  factory Book.fromMap(Map<String, dynamic> map) => Book(
        title: map['titulo'],
        description: map['descripcion'],
        url: map['enlace'],
      );

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  String title;
  String description;
  String url;
}

import 'package:flutter/foundation.dart';

class Todo {
  final int id;
  final String title;
  String description;
  String image;
  final DateTime dueDate;
  int tagId;

  Todo({
    this.id,
    @required this.title,
    this.description,
    this.image,
    @required this.dueDate,
    @required this.tagId,
  });

  Todo.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        image = json['image'],
        dueDate = DateTime.parse(json['due_date']),
        tagId = json['tag_id'];

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "image": image,
      "due_date": dueDate.toIso8601String(),
      "tag_id": tagId
    };
  }
}

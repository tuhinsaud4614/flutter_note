import 'package:flutter/foundation.dart';

class Tag {
  int id;
  final String name;
  final String color;
  bool isSelected;

  Tag({
    this.id,
    @required this.name,
    @required this.color,
    this.isSelected,
  });

  Tag.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = json['color'],
        isSelected = json['is_selected'] == 1 ? true : false;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "color": color,
      "is_selected": isSelected ? 1 : 0,
    };
  }
}

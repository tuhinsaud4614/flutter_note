import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/tag.dart';
import "../../providers/todo_provider.dart";

class TagItem extends StatelessWidget {
  final Tag tag;
  TagItem(this.tag);
  @override
  Widget build(BuildContext context) {
    print("[CustomTag] ${tag.color}");
    return ListTile(
      onTap: () async {
        Provider.of<TodoProvider>(context, listen: false)
            .tagSelection(tag.name)
            .then((_) {
          Navigator.pop(context, tag);
        });
      },
      leading: CircleAvatar(
        backgroundColor: Color(int.parse(tag.color)),
      ),
      // selected: tag['is_selected'] == 1,
      title: Text(
        "${tag.name.toUpperCase()}",
        style: TextStyle(
          fontFamily: "Tomorrow",
        ),
      ),
      trailing: Icon(
        Icons.check,
        color: tag.isSelected ? Theme.of(context).primaryColor : Colors.grey,
      ),
    );
  }
}

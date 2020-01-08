import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import '../widgets/ui/tag_item.dart';
import './new_tag.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("[TagPicker] build");
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 40.0,
            alignment: Alignment.center,
            child: Text("ADD TAG"),
          ),
          Divider(
            height: 0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomTags(),
                  NewTag(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: OutlineButton(
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "CANCEL",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTags extends StatefulWidget {
  // var oldData = [];
  @override
  _CustomTagsState createState() => _CustomTagsState();
}

class _CustomTagsState extends State<CustomTags> {
  bool _isLoading = true;

  @override
  void initState() {
    if (_isLoading) {
      Provider.of<TodoProvider>(context, listen: false)
          .fetchAndSetTags()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((onError) {
        print(onError);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("[_CustomTagsState]");
    final tags = Provider.of<TodoProvider>(context, listen: false).tags;
    return _isLoading
        ? Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: tags.map((tag) {
              return TagItem(tag);
            }).toList(),
          );
  }
}

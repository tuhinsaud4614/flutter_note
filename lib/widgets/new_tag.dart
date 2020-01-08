import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import '../models/tag.dart';

class NewTag extends StatefulWidget {
  @override
  _NewTagState createState() => _NewTagState();
}

class _NewTagState extends State<NewTag> {
  TextEditingController _newTagTxtController;
  bool _isNewTagged;
  Color newTagColor;

  @override
  void initState() {
    _isNewTagged = false;
    newTagColor = Colors.red;
    _newTagTxtController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _newTagTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("CustomAddTag");
    return _isNewTagged
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNewTagged = false;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _newTagTxtController,
                    decoration: InputDecoration(
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      hintText: "New tag name.",
                    ),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.bookmark,
                  ),
                  color: newTagColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text("Pick Color"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("BACK"),
                          ),
                        ],
                        content: Container(
                          height: 250,
                          constraints: BoxConstraints(
                            maxWidth: 350.0,
                          ),
                          child: MaterialColorPicker(
                            onMainColorChange: (Color color) {
                              setState(() {
                                newTagColor = color;
                              });
                              Navigator.pop(context);
                            },
                            allowShades: false,
                            selectedColor: newTagColor,
                            colors: [
                              Colors.red,
                              Colors.deepOrange,
                              Colors.yellow,
                              Colors.lightGreen
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.save,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    if (_newTagTxtController.text.trim().isNotEmpty) {
                      Provider.of<TodoProvider>(context, listen: false).saveTag(
                        Tag(
                            color: "${newTagColor.value.toString()}",
                            name:
                                _newTagTxtController.text.trim().toLowerCase(),
                            isSelected: true),
                      );
                    }
                    Navigator.pop(context);
                    _isNewTagged = false;
                  },
                ),
              ],
            ),
          )
        : FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              setState(() {
                _isNewTagged = true;
              });
            },
            child: Text(
              "New Tag",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}

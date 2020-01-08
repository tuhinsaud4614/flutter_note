import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import "../models/todo.dart";
import "../providers/todo_provider.dart";

import '../widgets/image_picking.dart';
import '../widgets/custom_dialog.dart';

class AddTodoScreen extends StatefulWidget {
  static const String routeName = "/add_todo";
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _image;
  DateTime _date = DateTime.now();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Todo _todoObj = Todo(
    title: null,
    description: null,
    dueDate: DateTime.now(),
    tagId: 1,
    image: null,
  );

  void imagePickingHandler(File image) {
    _image = base64.encode(image.readAsBytesSync());
    _todoObj = Todo(
      title: _todoObj.title,
      description: _todoObj.description,
      dueDate: _todoObj.dueDate,
      tagId: _todoObj.tagId,
      image: _image,
    );
  }

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _todoObj.tagId = Provider.of<TodoProvider>(context, listen: false).selectedTag.id;
    Provider.of<TodoProvider>(context, listen: false)
        .saveTodo(_todoObj)
        .then((_) {
      print("successful");
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_AddTodoScreenState");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo".toUpperCase()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveForm,
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${DateFormat("d MMMM yyy,").add_jm().format(DateTime.now())}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Tomorrow",
                      ),
                    ),
                    IconButton(
                      icon: Consumer<TodoProvider>(
                        builder: (context, todoData, child) => Icon(
                          Icons.bookmark,
                          color: todoData.selectedTag != null
                              ? Color(
                                  int.parse(todoData.selectedTag.color),
                                )
                              : Colors.blueAccent,
                        ),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => CustomDialog(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                color: Theme.of(context).secondaryHeaderColor,
                child: TextFormField(
                  initialValue: _titleController.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    border: InputBorder.none,
                    hintText: "Enter the todo\'s title here.*",
                  ),
                  onSaved: (String value) {
                    _todoObj = Todo(
                      title: value,
                      description: _todoObj.description,
                      dueDate: _todoObj.dueDate,
                      tagId: _todoObj.tagId,
                      image: _todoObj.image,
                    );
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                color: Theme.of(context).secondaryHeaderColor,
                child: TextFormField(
                  initialValue: _descriptionController.text,
                  validator: (value) => null,
                  onSaved: (String value) {
                    _todoObj = Todo(
                      title: _todoObj.title,
                      description: value,
                      dueDate: _todoObj.dueDate,
                      tagId: _todoObj.tagId,
                      image: _todoObj.image,
                    );
                  },
                  maxLines: 7,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).secondaryHeaderColor,
                    contentPadding: const EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText: "Enter the todo\'s desciption here.",
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2030),
                  ).then((date) {
                    if (date != null && date != _date) {
                      setState(() {
                        _date = date;
                      });
                      _todoObj = Todo(
                        title: _todoObj.title,
                        description: _todoObj.description,
                        dueDate: _date,
                        tagId: _todoObj.tagId,
                        image: _todoObj.image,
                      );
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text("Due Date: ${_date.toString()}"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ImagePicking(imagePickingHandler: imagePickingHandler),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import '../widgets/category_banner_card.dart';

class UpcomingTodo extends StatefulWidget {
  @override
  _UpcomingTodoState createState() => _UpcomingTodoState();
}

class _UpcomingTodoState extends State<UpcomingTodo> {
  final List<String> _categoryName = [
    "Meeting",
    "Personal",
    "Work",
    "Study",
    "txx",
    "txx"
  ];

  final List<List<Color>> _categoryCardColor = [
    [
      Color.fromRGBO(197, 96, 255, 1.0),
      Color.fromRGBO(135, 9, 206, 1.0),
    ],
    [
      Color.fromRGBO(255, 248, 182, 1.0),
      Color.fromRGBO(255, 189, 145, 1.0),
    ],
    [
      Color.fromRGBO(218, 248, 227, 1.0),
      Color.fromRGBO(0, 194, 199, 1.0),
    ],
    [
      Color.fromRGBO(255, 189, 145, 1.0),
      Color.fromRGBO(255, 141, 113, 1.0),
    ],
    [
      Color.fromRGBO(218, 248, 227, 1.0),
      Color.fromRGBO(0, 194, 199, 1.0),
    ],
    [
      Color.fromRGBO(255, 189, 145, 1.0),
      Color.fromRGBO(255, 141, 113, 1.0),
    ],
  ];
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false)
        .fetchAndSetTodos()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProviderData = Provider.of<TodoProvider>(context, listen: false);
    return !_isLoading
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 0),
            itemCount: todoProviderData.upComingTodos.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width - 30.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ...List.generate(
                          _categoryName.length,
                          (int index) => InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {},
                            child: CategoryBannerCard(
                              title: _categoryName[index],
                              // gradient: _categoryCardColor[
                              //     Random().nextInt(_categoryCardColor.length)],
                              isLastChild: index == _categoryName.length - 1
                                  ? true
                                  : false,
                              gradient: _categoryCardColor[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (index == 1) {
                return Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15.0,
                  ),
                  child: Text(
                    "Upcoming To-do's",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize:
                          Theme.of(context).primaryTextTheme.body2.fontSize *
                              1.3,
                      fontWeight: FontWeight.w700,
                      wordSpacing: 3.5,
                    ),
                  ),
                );
              }
              return todoProviderData.upComingTodos.length != 0 ? Card(
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  bottom: 10.0,
                ),
                child: ListTile(

                  contentPadding: const EdgeInsets.all(10.0),
                  onTap: () {},
                  leading: todoProviderData.upComingTodos[index - 2].image != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(
                            base64.decode(
                                todoProviderData.upComingTodos[index - 2].image),
                          ),
                        )
                      : null,
                  title: Text(
                    "${todoProviderData.upComingTodos[index - 2].title}",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize:
                          Theme.of(context).primaryTextTheme.body1.fontSize *
                              1.25,
                    ),
                  ),
                  
                  trailing: Text(
                      "${DateFormat("d MMMM yyy,").add_jm().format(todoProviderData.upComingTodos[index - 2].dueDate)}"),
                  subtitle:
                      todoProviderData.todos[index - 2].description != null
                          ? Text(
                              // "Now i'm going college. I have to ready for the college.",
                              "${todoProviderData.upComingTodos[index - 2].description} ${todoProviderData.upComingTodos[index - 2].tagId}",
                              style: TextStyle(
                                color: Colors.grey,
                                height: 2.0,
                                wordSpacing: 3.0,
                              ),
                            )
                          : null,
                ),
              ): Align(
                alignment: Alignment.topCenter,
                child: Text("No Upcoming Todos"),
              );
            },
          )
        : Align(
            child: CircularProgressIndicator(),
            alignment: Alignment.topCenter,
          );
  }
}

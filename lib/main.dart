import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_final/providers/todo_provider.dart';

import './screens/add_todo_screen.dart';
import './screens/home_screens/home.dart';

void main() => runApp(Todo());

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider.value(
      value: TodoProvider(),
      child: 
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: "Raleway",
          // brightness: Brightness.dark,
        ),
        // home: Home(),
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          Home.routeName: (BuildContext context) => Home(),
          AddTodoScreen.routeName: (BuildContext context) => AddTodoScreen(),
        },
      ),
    );
  }
}

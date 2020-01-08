import 'package:flutter/material.dart';

import './home_screen.dart';
import './settings_screen.dart';
import '../add_todo_screen.dart';
import '../../widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  static const String routeName = "/";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screenList = [
    HomeScreen(),
    Text("Scheduled"),
    Text("Calender"),
    SettingsScreen(),
  ];
  
  int _selectedIndex = 0;

  void _changeIndex(int currentIndex) {

    setState(() {
      _selectedIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add todo in your todo list",
        heroTag: "add_todo_page",
        onPressed: () {
          Navigator.of(context).pushNamed(AddTodoScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        changeIndex: _changeIndex,
      ),
    );
  }
}

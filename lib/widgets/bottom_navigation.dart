import 'package:flutter/material.dart';

import '../widgets/ui/bottom_appbar_button.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function changeIndex;

  BottomNavigation({@required this.selectedIndex, @required this.changeIndex});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BottomAppbarButton(
              "Home",
              changeIndex: changeIndex,
              ownIndex: 0,
              selectedIndex: selectedIndex,
              icon: Icons.home,
            ),
            BottomAppbarButton(
              "Scheduled",
              changeIndex: changeIndex,
              ownIndex: 1,
              selectedIndex: selectedIndex,
              icon: Icons.access_time,
            ),
            BottomAppbarButton(
              "Calender",
              changeIndex: changeIndex,
              ownIndex: 2,
              selectedIndex: selectedIndex,
              icon: Icons.calendar_today,
            ),
            BottomAppbarButton(
              "Settings",
              changeIndex: changeIndex,
              ownIndex: 3,
              selectedIndex: selectedIndex,
              icon: Icons.settings,
            ),
          ],
        ),
    );
    // return BottomNavigationBar(
    //     currentIndex: selectedIndex,
    //     onTap: changeIndex,
    //     type: BottomNavigationBarType.fixed,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         title: Text("Home"),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.access_time),
    //         title: Text("Scheduled"),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.calendar_today),
    //         title: Text("Calender"),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         title: Text("Settings"),
    //       ),
    //     ],
    //   );
  }
}

import 'package:flutter/material.dart';

class BottomAppbarButton extends StatelessWidget {
  final Function changeIndex;
  final int selectedIndex;
  final int ownIndex;
  final IconData icon;
  final String text;
  BottomAppbarButton(this.text,
      {@required this.changeIndex,
      @required this.selectedIndex,
      @required this.ownIndex,
      @required this.icon})
      : assert(text != null,
            "A non-null String must be provided to a Text widget.");
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => changeIndex(ownIndex),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              // size: 18.0,
              color: selectedIndex == ownIndex
                  ? Theme.of(context).primaryColor
                  : Colors.black,
            ),
            Text(
              text.toUpperCase(),
              style: TextStyle(
                // fontSize: 10.0,
                color: selectedIndex == ownIndex
                    ? Theme.of(context).primaryColor
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

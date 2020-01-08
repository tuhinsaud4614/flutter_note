import 'package:flutter/material.dart';

class CategoryBannerCard extends StatelessWidget {
  final String title;
  final List<Color> gradient;
  final bool isLastChild;
  CategoryBannerCard({
    @required this.title,
    @required this.gradient,
    @required this.isLastChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          isLastChild ? EdgeInsets.only(right: 0) : EdgeInsets.only(right: 10),
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: [
            gradient[0],
            gradient[1],
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          // stops: [0.2, 1],
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context).primaryTextTheme.display1.fontSize * 0.7,
          color: Colors.white,
          fontFamily: "Tomorrow",
        ),
      ),
    );
  }
}

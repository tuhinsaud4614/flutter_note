import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/weather_date.dart';
import "../../widgets/upcoming_todo.dart";
import '../../widgets/weather_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hey Tuhin!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize:
                      Theme.of(context).primaryTextTheme.body1.fontSize * 1.25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "What is your plan?",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize:
                      Theme.of(context).primaryTextTheme.body2.fontSize * 1.4,
                  fontWeight: FontWeight.w900,
                  wordSpacing: 3.5,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FloatingActionButton(
                elevation: 1,
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {},
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        ChangeNotifierProvider.value(
          value: WeatherDate(),
          child: WeatherCard(),
        ),
        Expanded(
          child: UpcomingTodo(),
        ),
      ],
    );
  }
}

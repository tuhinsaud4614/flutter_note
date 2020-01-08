import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/weather_date.dart';

class DateFormationCustom {
  String day;
  String monthAndDay;
  String time;

  void correctFormat(DateTime current) {
    day = DateFormat.EEEE('en_US').format(current);
    monthAndDay = DateFormat.MMMMd().format(current);
    time = DateFormat.jm().format(current);
  }

  void currentDateTime(DateTime current) {
    this.correctFormat(current);
    // print("Day: $day");
    // print("Month day: $monthAndDay");
    // print("Time: $time");
  }
}

class WeatherCard extends StatefulWidget {
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String currentTemperaure = "20";
  bool _isInit = true;
  int counter = 0;

  DateFormationCustom dateFormationCustom;
  Timer timer;
  @override
  void initState() {
    dateFormationCustom = DateFormationCustom();
    dateFormationCustom.correctFormat(DateTime.now());
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        dateFormationCustom.currentDateTime(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // print("Weather card didChangeDependencies()");
    if (_isInit) {
      _isInit = false;
      try {
        await Provider.of<WeatherDate>(context).getTemperature();
      } catch (err) {
        if (err.runtimeType == SocketException) {
          _showSnackBar(
            context,
            "No Internet connection. Weather can\'t be updated.",
          );
        } else {
          _showSnackBar(
            context,
            "Something went wrong for weather.",
          );
        }
      }
    }
    super.didChangeDependencies();
  }

  void _showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      shape: BeveledRectangleBorder(),
      action: SnackBarAction(
        label: "HIDE",
        textColor: Colors.white,
        onPressed: () => {Scaffold.of(context).hideCurrentSnackBar()},
      ),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    // print("WeatherCard Render: $counter");
    // counter += 1;
    var weatherAndDateInfo = Provider.of<WeatherDate>(context, listen: false)
        .currentWeatherAndDateInfo;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(197, 96, 255, 0.7),
            Color.fromRGBO(135, 9, 206, 1.0),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.2, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 7.0,
            spreadRadius: 3.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      height: 1.0,
                      fontSize:
                          Theme.of(context).primaryTextTheme.body1.fontSize),
                  children: [
                    TextSpan(
                      text: "${dateFormationCustom.day}\n",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "${dateFormationCustom.monthAndDay}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${dateFormationCustom.time}",
                style: TextStyle(
                  height: 1.3,
                  fontSize:
                      Theme.of(context).primaryTextTheme.headline.fontSize,
                  color: Colors.white,
                  fontFamily: "Tomorrow",
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              weatherAndDateInfo["icon"] == "Unknown"
                  ? Text(
                      "${weatherAndDateInfo["temperature"]}\u2103",
                      style: TextStyle(
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .subtitle
                            .fontSize,
                        color: Colors.white,
                        fontFamily: "Tomorrow",
                      ),
                    )
                  : Row(
                      children: <Widget>[
                        Image.network(
                          "http://openweathermap.org/img/w/${weatherAndDateInfo["icon"]}.png",
                          fit: BoxFit.cover,
                          height: 30.0,
                          width: 30.0,
                          color: Colors.white,
                        ),
                        Text(
                          "${weatherAndDateInfo["temperature"]}\u2103",
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .primaryTextTheme
                                .title
                                .fontSize,
                            color: Colors.white,
                            fontFamily: "Tomorrow",
                          ),
                        ),
                      ],
                    ),
              Text(
                "${weatherAndDateInfo["name"]}",
                // "hi",
                style: TextStyle(
                  fontSize: Theme.of(context).primaryTextTheme.body1.fontSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../utils/PlatformExceptionMsg.dart';

class WeatherDate with ChangeNotifier {
  Map<String, dynamic> weatherAndDateInfo = <String, dynamic>{
    "temperature": "0",
    "dayState": "Unknown",
    "icon": "Unknown",
    "name": "Unknown"
  };

  Map<String, dynamic> get currentWeatherAndDateInfo {
    return weatherAndDateInfo;
  }

  Future<void> getTemperature() async {
    var location = Location();

    try {
      LocationData currentLocation = await location.getLocation();
      // print(currentLocation.latitude);
      // print(currentLocation.longitude);
      // units = metric define celsius temperature
      String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=${currentLocation.latitude}&lon=${currentLocation.longitude}&appid=e5e672d68b050dac38838b245de31050&units=metric";

      final result = await http.get(url);
      var data = json.decode(result.body);
      //
      // double temp = (((data['main']['temp'] - 273.15) * 9 / 5) + 32);
      // print(data['main']['temp']);
      String dayState = data["weather"][0]["main"];
      weatherAndDateInfo = {
        "temperature": data['main']['temp'].toString(),
        "dayState": dayState,
        "icon": data["weather"][0]["icon"],
        "name": data["name"]
      };
      // print(weatherAndDateInfo);
      notifyListeners();
    } on PlatformException catch (err) {
      if (err.code == 'PERMISSON_DENIED') {
        print("Permission Denied");
        throw PlatformExceptionMsg('PERMISSON_DENIED');
      }
    } 
    catch (err) {
      throw err;
    }
  }
}

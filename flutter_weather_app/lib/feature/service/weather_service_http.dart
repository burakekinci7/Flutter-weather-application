import 'dart:convert';

import 'package:flutter_weather_app/feature/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServiceHttp {
  final aipKey = "78a2520041c2118d70cb7feb350cfa50";

  Future getData(double lat, double long) async {
    final apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=78a2520041c2118d70cb7feb350cfa50&lang=tr";
    Uri apiUri = Uri.parse(apiUrl);

    try {
      final responce = await http.get(apiUri);

      if (responce.statusCode == 200) {
        final json = jsonDecode(responce.body);
        return WeatherAppModel.fromJson(json);
      }
    } catch (e) {
      return;
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/feature/model/weather_model.dart';

class WeatherSerivceDio {
  //dio class
  static final Dio _dio = Dio();

  static const String apiUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=Istanbul&appid=78a2520041c2118d70cb7feb350cfa50";

  //no model - return json file
  static Future<Response> getData() async {
    final responce = await _dio.get(apiUrl);
    return responce;
  }

  //in model - save data and modelling data and classification data
  static Future getDataDio(String city) async {
    final api =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=78a2520041c2118d70cb7feb350cfa50&units=metric&lang=tr";
    try {
      final response = await _dio.get(api);
      if (response.statusCode == 200) {
        final json = jsonDecode(jsonEncode(response.data));
        return WeatherAppModel.fromJson(json);
      }
    } catch (e) {
      return;
    }
  }
}

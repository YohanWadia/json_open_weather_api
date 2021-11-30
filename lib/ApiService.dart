// ignore_for_file: file_names

import 'dart:convert';

import 'package:json_open_weather_api/MyWeatherPOJO.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<MyWeatherPOJO> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
print("------------------$city");
    final queryParameters = {
      'q': city,
      'appid': '86d0a6fcb0b4438a4ce9577b8ed46e04',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return MyWeatherPOJO.fromJson(json);
  }
}
// http: ^0.13.4
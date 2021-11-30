// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceTempOnly {
  Future<double> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    print("from TEMPONLY ,,,, $city");
    final queryParameters = {
      'q': city,
      'appid': '86d0a6fcb0b4438a4ce9577b8ed46e04',
      'units': 'metric'
    };

    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    print(json["main"]["temp"]);
    return json["main"]["temp"];
  }
}
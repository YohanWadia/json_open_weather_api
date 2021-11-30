import 'package:flutter/material.dart';
import 'package:json_open_weather_api/ApiServiceTempOnly.dart';
import 'package:json_open_weather_api/MyWeatherPOJO.dart';

import 'ApiService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final apiService = ApiService();
  final apiServiceTempOnly = ApiServiceTempOnly();

  MyWeatherPOJO? _response ;
  List temps = [0.0,0.0,0.0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_response != null)
                  Column(
                    children: [
                      Image.network(_response!.iconUrl),
                      Text(
                        '${_response!.tempInfo.temperature}°',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(_response!.weatherInfo.description)
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City'),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search')),
                SizedBox(height:20),
                ElevatedButton(onPressed: my3, child: Text('3 cities')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vilnius"),
                      Text(temps[0].toString())
                    ],),
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Riga"),
                        Text(temps[1].toString())
                      ],),
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tahlinn"),
                        Text(temps[2].toString())
                      ],)
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _search() async {
    final response = await apiService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }

  void my3() async {
    temps = await Future.wait([apiServiceTempOnly.getWeather("Vilnius"),
                               apiServiceTempOnly.getWeather("Riga"),
                               apiServiceTempOnly.getWeather("Tallinn")]);
    setState(() => temps = temps);
  }
}
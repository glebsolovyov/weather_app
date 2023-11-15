import '../models/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fetchWeather() async {

  const cityName = "Krasnodar";
  const apiKey = "6ef0b3ebe8fb6a2f140ebdeac5a09332";
  const apiUrl =
      "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=$apiKey";

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body) as Map<dynamic, dynamic>;
    var weatherList = [];

    for (var item in jsonData["list"]) {
      var weatherListItem = Weather.fromJson(item, cityName);
      weatherList.add(weatherListItem);
    }

    return weatherList;
  } else {
    throw Exception('Failed to load weather');
  }
}
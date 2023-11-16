import 'package:weather_app/models/dayly_weather.dart';

import '../models/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, List>> fetchWeather() async {

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
    var daylyWeatherList = [];
    Map<String, dynamic> weatherMap = {};


    for (var item in jsonData["list"]) {
      var date = item["dt_txt"].split(' ')[0];
      if (weatherMap.isEmpty | !weatherMap.containsKey(date)){

        weatherMap[date] = [];
        weatherMap[date].add(item);
      }
      else{
        weatherMap[date].add(item);
      }
    }
    for (var key in weatherMap.keys){
      var daylyWeatherListItem = DaylyWeather.fromJson(weatherMap[key], key);
      daylyWeatherList.add(daylyWeatherListItem);
    }

    Map<String, List> weatherData = {
      "hourly": weatherList,
      "dayly": daylyWeatherList
    };
    return weatherData;
  } else {
    throw Exception('Failed to load weather');
  }
}
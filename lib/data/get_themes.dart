import 'package:flutter/material.dart';
import 'package:weather_app/data/weather_data_provider.dart';
import 'package:weather_app/data/database.dart';

import '../models/city.dart';

Future<String> getWeatherDescription() async {
  var selectedCity = await DBProvider.db.getSelectedCity();
  var weatherData = await fetchWeather(selectedCity!.name);

  var weatherDescription = weatherData["dayly"]![0].description;
  return weatherDescription;
}

Future<ThemeData> getTheme() async {
  var weatherDescription = await getWeatherDescription();
  switch (weatherDescription) {
    case "Clear" || "Snow":
      return ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(150, 222, 248, 1),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromRGBO(150, 222, 248, 1)));
    default:
      return ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(111, 118, 128, 1),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromRGBO(111, 118, 128, 1)));
  }
}

Future<Color> getColor() async {
  var weatherDescription = await getWeatherDescription();
  switch (weatherDescription) {
    case "Clear" || "Snow":
      return Color.fromRGBO(150, 222, 248, 1);
    default:
      return Color.fromRGBO(111, 118, 128, 1);
  }
}

SizedBox getIcon(String weatherDescription) {
  switch (weatherDescription) {
    case "Thunderstorm":
      return SizedBox(
          height: 40,
          width: 100,
          child: Image.asset("assets/images/thunderstorm.png"));
    case "Drizzle" || "Rain":
      return SizedBox(
          height: 40, width: 100, child: Image.asset("assets/images/rain.png"));
    case "Snow":
      return SizedBox(
          height: 40, width: 100, child: Image.asset("assets/images/snow.png"));
    case "Clear":
      return SizedBox(
          height: 40,
          width: 100,
          child: Image.asset("assets/images/contrast.png"));
    case "Clouds":
      return SizedBox(
          height: 40,
          width: 100,
          child: Image.asset("assets/images/cloud.png"));
    default:
      return SizedBox(
          height: 40,
          width: 100,
          child: Image.asset("assets/images/cloud.png"));
  }
}

String getTranslate(String weatherDescription) {
  switch (weatherDescription) {
    case "Thunderstorm":
      return "Гроза";
    case "Drizzle":
      return "Мелкий дождь";
    case "Rain":
      return "Дождь";
    case "Snow":
      return "Снег";
    case "Clear":
      return "Ясно";
    case "Clouds":
      return "Облачно";
    default:
      return "Sunny";
  }
}

SizedBox getButton(City city) {
  var isSelected = DBProvider.db.isCitySelected(city);
  if (isSelected) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        icon: Image.asset("assets/images/heart-2.png"),
        onPressed: () {
          DBProvider.db.setSelected(city);
        },
      ),
    );
  }
  return SizedBox(
    width: 30,
    height: 30,
    child: IconButton(
      icon: Image.asset("assets/images/heart.png"),
      onPressed: () {
        DBProvider.db.setSelected(city);
      },
    ),
  );
}

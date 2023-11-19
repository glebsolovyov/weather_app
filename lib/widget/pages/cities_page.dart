import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/data/weather_data_provider.dart';

import '../../data/result.dart';
import '../../models/city.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPage();
}

class _CitiesPage extends State<CitiesPage> with TickerProviderStateMixin {
  String _newCityName = "";
  bool correctCity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            decoration: InputDecoration(
                errorText: !correctCity ? "Город не найден" : null),
            onFieldSubmitted: (text) async {
              try {
                await fetchWeather(text);
                DBProvider.db.newCity(text);
              } on Exception catch (_) {
                setState(() {
                  correctCity = false;
                });
              }
            },
          ),
        ),
        body: FutureBuilder(
            future: DBProvider.db.getAllCities(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      return FutureBuilder<Map<String, List>>(
                          future: fetchWeather(snapshot.data![index].name),
                          builder: (context, citySnapshot) {
                            if (citySnapshot.hasData) {
                              final hourlyData =
                                  citySnapshot.data!["hourly"]![0];
                              return Card(
                                child: Row(
                                  children: [
                                    Text(snapshot.data![index].name),
                                    Text(hourlyData.temp.toString())
                                  ],
                                ),
                              );
                            } else {
                              return Text("Нет инф");
                            }
                          });
                    }));
              } else {
                return Text("Города не добавлены");
              }
            }));
  }
}

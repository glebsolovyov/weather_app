import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/data/weather_data_provider.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPage();
}

class _CitiesPage extends State<CitiesPage> with TickerProviderStateMixin {
  String _newCityName = "";
  bool correctCity = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text("Города"),
              bottom: const TabBar(
                tabs: <Widget>[Tab(text: "Список"), Tab(text: "Поиск")],
              )),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder(
                  future: DBProvider.db.getAllCities(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: ((context, index) {
                            return FutureBuilder<Map<String, List>>(
                                future:
                                    fetchWeather(snapshot.data![index].name),
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
                  }),
              Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      errorText: error ? "Город не найден" : null),
                  onFieldSubmitted: (text) async {
                    try {
                      await fetchWeather(text);
                      setState(() {
                        correctCity = true;
                        error = false;
                        _newCityName = text;
                      });
                    } on Exception catch (_) {
                      setState(() {
                        error = true;
                        correctCity = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 100,
                  child: Visibility(
                    visible: correctCity,
                    child: FutureBuilder(
                        future: fetchWeather(_newCityName),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final hourlyData = snapshot.data!["hourly"]![0];
                            return Card(
                                child: Row(
                              children: [
                                Text(hourlyData.city.toString()),
                                Text(hourlyData.temp.toString()),
                                FutureBuilder(
                                    future: DBProvider.db
                                        .isContainsCity(_newCityName),
                                    builder: (context, citySnapshot) {
                                      if (citySnapshot.hasData) {
                                        return FutureBuilder(
                                            future: DBProvider.db
                                                .getCityIdByName(_newCityName),
                                            builder: (context, cityIdSnapshot) {
                                              if (cityIdSnapshot.hasData) {
                                                return !citySnapshot.data!
                                                    ? ElevatedButton(
                                                        onPressed: () {
                                                          DBProvider.db.newCity(
                                                              _newCityName);
                                                        },
                                                        child: Icon(Icons.add))
                                                    : ElevatedButton(
                                                        onPressed: () {
                                                          DBProvider.db
                                                              .deleteCity(
                                                                  cityIdSnapshot
                                                                      .data!);
                                                        },
                                                        child:
                                                            Icon(Icons.remove));
                                              } else {
                                                return Text("Ошибка");
                                              }
                                            });
                                      } else {
                                        return Text("Ошибка");
                                      }
                                    })
                              ],
                            ));
                          } else {
                            return Text("Загрузка");
                          }
                        }),
                  ),
                )
              ]),
            ],
          )),
    );
  }
}

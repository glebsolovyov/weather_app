import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/data/weather_data_provider.dart';
import 'package:weather_app/widget/pages/home_page.dart';

import '../../data/get_themes.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPage();
}

class _CitiesPage extends State<CitiesPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  String _newCityName = "";
  bool correctCity = false;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
       future: getColor(),
        builder: (context, snap) =>
        Scaffold(
        backgroundColor: snap.data,
          appBar: AppBar(
            backgroundColor: snap.data,
            title: Text("Города"),
            bottom: TabBar(
              controller: _tabController,
              tabs: <Widget>[Tab(text: "Список"), Tab(text: "Поиск")],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              FutureBuilder(
                future: DBProvider.db.getAllCities(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: ((context, index) {
                          return FutureBuilder<Map<String, List>>(
                              future:
                                  fetchWeather(snapshot.data![index].name),
                              builder: (context, citySnapshot) {
                                if (citySnapshot.hasData) {
                                  final hourlyData =citySnapshot.data!["hourly"]![0];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 50,
                                      decoration: myBoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: 140,
                                                child: Text(snapshot.data![index].name)),
                                            SizedBox(
                                              width: 120,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4),
                                                    child: SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset("assets/images/thermometer.png"),
                                                    ),
                                                  ),
                                                  Text("${hourlyData.temp.toString()}°")
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: FutureBuilder(
                                                    future: DBProvider.db.isCitySelected(snapshot.data![index],),
                                                    builder: (context, selectedSnapshot) {
                                                      if (selectedSnapshot.hasData){
                                                      var isSelected = selectedSnapshot.data as bool;
                                                      if (isSelected) {
                                                        return SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: IconButton(
                                                            icon: Image.asset("assets/images/heart-2.png"),
                                                            onPressed: () {
                                                              DBProvider.db.setSelected(snapshot.data![index],);
                                                              setState(() {});
                                                            },
                                                          ),
                                                        );
                                                      } else {
                                                      return SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: IconButton(
                                                          icon: Image.asset("assets/images/heart.png"),
                                                          onPressed: () { 
                                                            DBProvider.db.setSelected(snapshot.data![index],);
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                      return Text("Error");
                                                    }
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: IconButton(
                                                icon: Image.asset("assets/images/cancel.png"),
                                                onPressed: () {
                                                  DBProvider.db.deleteCity(snapshot.data![index].id);
                                                  setState(() {});
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text("Нет инф");
                                }
                              });
                        })),
                  );
                } else {
                  return Text("Города не добавлены");
                }
              }),
          Padding(
            padding: EdgeInsets.only(right: 15, left: 15),
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Введите название города",
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
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                                decoration: myBoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 150,
                                          child: Text(
                                              hourlyData.city.toString())),
                                      SizedBox(
                                        width: 110,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: Image.asset(
                                                    "assets/images/thermometer.png"),
                                              ),
                                            ),
                                            Text(
                                                "${hourlyData.temp.toString()}°")
                                          ],
                                        ),
                                      ),
                                      FutureBuilder(
                                          future: DBProvider.db
                                              .isContainsCity(_newCityName),
                                          builder: (context, citySnapshot) {
                                            if (citySnapshot.hasData) {
                                              return FutureBuilder(
                                                  future: DBProvider.db
                                                      .getCityIdByName(
                                                          _newCityName),
                                                  builder: (context,
                                                      cityIdSnapshot) {
                                                    if (cityIdSnapshot
                                                        .hasData) {
                                                      return !citySnapshot
                                                              .data!
                                                          ? SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child:
                                                                  IconButton(
                                                                icon: Image.asset(
                                                                    "assets/images/plus.png"),
                                                                onPressed:
                                                                    () {
                                                                  DBProvider
                                                                      .db
                                                                      .newCity(
                                                                          _newCityName);
                                                                },
                                                              ))
                                                          : SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child:
                                                                  IconButton(
                                                                icon: Image.asset(
                                                                    "assets/images/cancel.png"),
                                                                onPressed:
                                                                    () {
                                                                  DBProvider
                                                                      .db
                                                                      .deleteCity(
                                                                          cityIdSnapshot.data!);
                                                                },
                                                              ));
                                                    } else {
                                                      return Text("Ошибка");
                                                    }
                                                  });
                                            } else {
                                              return Text("Ошибка");
                                            }
                                          })
                                      ],
                                    ),
                                  )),
                              );
                            } else {
                              return Text("Загрузка");
                            }
                          }),
                    ),
                  )
                ]),
              ),
            ],
          )),
    );
  }
}

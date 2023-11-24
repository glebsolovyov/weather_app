import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/data/get_themes.dart';

import '../ components/city.dart';
import '../ components/description.dart';
import '../ components/temperature.dart';
import '../../data/weather_data_provider.dart';
import '../../models/city.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getColor(),
      builder: (context, snap) =>
      Scaffold(
        backgroundColor: snap.data,
        body: SafeArea(
          child: FutureBuilder<City?>(
              future: DBProvider.db.getSelectedCity(),
              builder: (context, citySnapshot) {
                if (citySnapshot.hasData) {
                  return FutureBuilder<Map<String, List>>(
                    future: fetchWeather(citySnapshot.data!.name),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final hourylyData = snapshot.data!["hourly"];
                        final dailyData = snapshot.data!["dayly"];
                        return Center(
                            child: Column(children: [
                          CityWidget(data: hourylyData![0]!.city),
                          MainTemperature(
                              data: ("${hourylyData[0].temp.toString()}°")),
                          Description(
                              data: getTranslate(hourylyData[0].description)),
                          Expanded(
                            child: Padding(
                                padding:
                                    EdgeInsets.only(top: 50, right: 15, left: 15),
                                child: Column(children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 20),
                                    height: 100,
                                    decoration: myBoxDecoration(),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: hourylyData.length,
                                      itemBuilder: (context, index) => SizedBox(
                                        height: 50,
                                        width: 100,
                                        child: Center(
                                          child: Column(children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, top: 10),
                                                child: Text(hourylyData[index].time.toString())),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 5),
                                              child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: getIcon(hourylyData[index].description),
                                              ),
                                            ),
                                            HourlyTemperature(
                                                data: ("${hourylyData[0].temp.toString()}°")),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: dailyData?.length,
                                        itemBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Container(
                                            height: 50,
                                            decoration: myBoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 20),
                                              child: Row(children: [
                                                SizedBox(
                                                  width: 110,
                                                  child: Text(dailyData![index].weekday.toString()),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 5),
                                                        child: SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child: Image.asset("assets/images/thermometer.png"),
                                                        ),
                                                      ),
                                                      Text("${dailyData[index].averageTemp.toString()}°")
                                                    ],
                                                  ),
                                                ),
                                                getIcon(dailyData[index].description.toString(),
                                                ),
                                                SizedBox(
                                                  width: 80,
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 5),
                                                      child: SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child: Image.asset("assets/images/wind.png"),
                                                      ),
                                                    ),
                                                    Text("${dailyData[index].averageWindSpeed.toString()} м/с"),
                                                  ]),
                                                )
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ])),
                          ),
                        ]));
                      } else {
                        return const Text('Data is empty');
                      }
                    },
                  );
                } else {
                  return Text("Город не выбран");
                }
              }),
        ),
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    color: Colors.white.withOpacity(0.2),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );
}

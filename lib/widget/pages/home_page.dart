import 'package:flutter/material.dart';
import 'package:weather_app/data/Database.dart';

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
    return SafeArea(
      child: FutureBuilder<City?>(
        future: DBProvider.db.getSelectedCity(),
        builder: (context, citySnapshot) {
        if (citySnapshot.hasData){
          return  FutureBuilder<Map<String, List>>(
            future: fetchWeather(citySnapshot.data!.name),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final hourylyData = snapshot.data!["hourly"];
                final daylyData = snapshot.data!["dayly"];
                
                return Scaffold(
                  appBar: AppBar(
                    surfaceTintColor: Colors.transparent,
                    title: CityWidget(data: hourylyData?[0].city),
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        MainTemperature(data: ("${hourylyData?[0].temp.toString()}°")),
                        Description(data: hourylyData?[0].description),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50, right: 15, left: 15),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                    height: 140,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 20),
                                      height: 100,
                                      decoration: myBoxDecoration(),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: hourylyData?.length,
                                        itemBuilder: (context, index) => SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                padding: EdgeInsets.only(bottom: 5, top:10),
                                                child: Text(hourylyData![index].time.toString())),
                                                Padding(
                                                padding: EdgeInsets.only(bottom: 5),
                                                child: Icon(Icons.cloud)),
                                                HourlyTemperature(data: ("${hourylyData[0].temp.toString()}°")),
                                              ]
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 350,
                              child: Container(
                                decoration: myBoxDecoration(),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: daylyData?.length,
                                  itemBuilder: (context, index) =>
                                    Card(
                                      child: Row(
                                        children: [SizedBox(
                                          width: 120,
                                          height: 50,
                                          child: Text(daylyData![index].weekday.toString()),),
                                          SizedBox(
                                          width: 70,
                                          height: 50,
                                          child: Text("${daylyData[index].averageTemp.toString()}°"),),
                                          SizedBox(
                                          width: 90,
                                          height: 50,
                                          child: Text(daylyData[index].description.toString()),),
                                          SizedBox(
                                          width: 40,
                                          height: 50,
                                          child: Text(daylyData[index].averageWindSpeed.toString()),),
                                        ]
                                      ),
                                    )
                                    ),
                              ),
                            )
                                              ]);
                              },
                                            ),
                          ),
                        ),
                    ])
                  ),
                );
              } else {
                return const Text('Data is empty');
              }
            },
          );
  
  }else {
    return Text("Город не выбран");
  }}
  ),
);
  }
}
BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 3.0
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(10.0)
    ),
  );
}
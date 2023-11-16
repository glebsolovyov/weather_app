import 'package:flutter/material.dart';

import '../ components/city.dart';
import '../ components/description.dart';
import '../ components/temperature.dart';
import '../../data/weather_data_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Future<Map<String, List>> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = fetchWeather();

    
  }

  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      child: FutureBuilder<Map<String, List>>(
          future: _weatherData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final hourylyData = snapshot.data!["hourly"];
              final daylyData = snapshot.data!["dayly"];
              
              return Scaffold(
                appBar: AppBar(
                  title: City(data: hourylyData?[0].city),
                ),
                body: Center(
                  child: Column(
                    children: [
                      Temperature(data: hourylyData?[0].temp),
                      Description(data: hourylyData?[0].description),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hourylyData?.length,
                          itemBuilder: (context, index) => SizedBox(
                            height: 50,
                            width: 60,
                            child: ListTile(
                              title: Text(hourylyData![index].temp.toString()),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: daylyData?.length,
                          itemBuilder: (context, index) =>
                            Row(
                              children: [Expanded(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Text(daylyData![index].date.toString()),),
                              ),
                                Expanded(
                                  child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Text(daylyData[index].averageTemp.toString()),),
                                ),
                                Expanded(
                                  child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Text(daylyData[index].description.toString()),),
                                ),
                              ]
                            )
                            ),
                          ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Data is empty');
            }
          },
        ),
    );
  }
}

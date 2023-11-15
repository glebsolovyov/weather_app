import 'package:flutter/material.dart';

import ' components/city.dart';
import ' components/description.dart';
import ' components/temperature.dart';
import '../data/weather_data_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Future<List> _futureWeather;

  @override
  void initState() {
    super.initState();
    _futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Krasnodar")
        ),
        body: FutureBuilder<List>(
          future: _futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;

              return Center(
                child: Column(
                  children: [
                    City(data: data[0].city),
                    Temperature(data: data[0].temp),
                    Description(data: data[0].description),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: 50,
                          width: 60,
                          child: ListTile(
                            title: Text(data[index].temp.toString()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Data is empty');
            }
          },
        ),
      ),
    );
  }
}

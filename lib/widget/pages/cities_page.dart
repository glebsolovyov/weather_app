import 'package:flutter/material.dart';
import 'package:weather_app/data/Database.dart';
import 'package:weather_app/data/weather_data_provider.dart';

import '../../models/city.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPage();
}

class _CitiesPage extends State<CitiesPage> with TickerProviderStateMixin {
  String _newCityName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:TextField(
              onSubmitted: (text) {
                // setState(() {
                //   _newCityName = text;
                // });
                print(fetchWeather(text) == null);

                try{
                  fetchWeather(text);
                }
                on Object catch (e) {
                  print(e);
                }
                print("on sumbitted");
                Text("on sumbitted");
                // Center(
                //   child: FutureBuilder(
                //     future: fetchWeather(text),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData){
                //         print("fdsfd");
                //         return Text(snapshot.data.toString());
                //       }
                //       else {
                //         return Text("fdsf");
                //       }
                //     },),
                // );
                // DBProvider.db.newCity(text);
                // } else {
                //   Text("Город не найден");
                // }

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
                builder: (context, citySnapshot){
                  if (citySnapshot.hasData){
                  final hourlyData = citySnapshot.data!["hourly"]![0];
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
                } 
                );
            }
            ));
        }else {
          return Text("Города не добавлены");
        }}
        )
    );
  }

}
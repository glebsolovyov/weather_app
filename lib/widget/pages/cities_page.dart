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
        title:
          Expanded(
            child: TextField(
              onSubmitted: (text) {
                setState(() {
                  _newCityName = text;
                });
                DBProvider.db.newCity(text);
              },
            ),
          ),
      ),
               body: FutureBuilder<List<City>>(
                     future: DBProvider.db.getAllCities(),
                     builder:(context, AsyncSnapshot<List<City>> snapshot) {
                       if (snapshot.data != null) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder:(context, index) {
                              // return FutureBuilder<Map<String, List>>(
                              //   future: fetchWeather(),
                              //   builder: (context, weatherSnapshot) {(
                              //     child: Text(snapshot.data![index].name),
                              //     );
                              //   }
                              // );
                              }
                            );
                        } else {
                            return Center(
                              child: Text("fds")
                        );
                       }
                     },
                  ),
             );

            
      


  }

}
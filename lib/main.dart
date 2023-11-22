import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'data/get_themes.dart';
import 'widget/ components/bottom_navigation.dart';

void main() async {
  runApp(const MyApp());
  await DBProvider.db.database;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTheme(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
                title: 'Weather app',
                theme: snapshot.data,
                home: const BottomNavigation());
          } else {
            return MaterialApp(
                title: 'Weather app',
                theme: ThemeData(
                  scaffoldBackgroundColor: Color.fromRGBO(111, 118, 128, 1),
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
                ),
                home: const BottomNavigation());
          }
        });
  }
}

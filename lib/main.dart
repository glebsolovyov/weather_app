import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'widget/ components/bottom_navigation.dart';

void main() async{
  runApp(const MyApp());
  await DBProvider.db.database;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const BottomNavigation(),
    );
  }
}

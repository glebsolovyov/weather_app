import 'package:flutter/material.dart';
import 'package:weather_app/data/database.dart';
import 'package:weather_app/widget/pages/auth_screen.dart';
import 'data/get_themes.dart';
import 'widget/ components/bottom_navigation.dart';

void main() async {
  runApp(const MyApp());
  await DBProvider.db.database;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        ),
        home: FutureBuilder(
          future: DBProvider.db.getLoginUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return BottomNavigation();
            }
            return AuthScreen();
          }
          )
    );
  }
}

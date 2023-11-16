import 'package:flutter/material.dart';
import 'widget/ components/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
  // dbConnect();
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

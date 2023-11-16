import 'package:flutter/material.dart';
import 'package:weather_app/data/db_city.dart';
import 'package:weather_app/models/city.dart';

import '../pages/cities_page.dart';
import '../pages/home_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch(selectedIndex){
      case 0:
        page = MyHomePage();
      case 1:
        page = CitiesPage();
      case 2:
        page = Placeholder();
      default:
        throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
        body: page,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Погода"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Города"),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: "Комментарии"),
        ],
        currentIndex: selectedIndex,
        onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },),
      );
  }
}

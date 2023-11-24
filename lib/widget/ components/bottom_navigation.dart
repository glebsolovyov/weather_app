import 'package:flutter/material.dart';
import 'package:weather_app/data/get_themes.dart';

import '../pages/cities_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    
    switch (selectedIndex) {
      case 0:
        page = MyHomePage();
      case 1:
        page = CitiesPage();
      case 2:
        page = ProfileScreen();
      default:
        throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: FutureBuilder(
          future: getColor(),
          builder: (context, snapshot) {
            return BottomNavigationBar(
              backgroundColor: snapshot.data,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Погода"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_city), label: "Города"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Профиль"),
              ],
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';

class MainTemperature extends StatelessWidget {
  const MainTemperature({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) => Text(
        data.toString(),
        style: const TextStyle(fontSize: 80),
      );
}

class HourlyTemperature extends StatelessWidget {
  const HourlyTemperature({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) => Text(
        data.toString(),
        style: const TextStyle(fontSize: 15),
      );
}
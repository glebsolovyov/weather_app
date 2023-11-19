import 'package:flutter/material.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) => Text(
        data.toString(),
        style: const TextStyle(fontSize: 30),
      );
}

import 'package:flutter/material.dart';

class City extends StatelessWidget {
  const City({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) => Text(
        data.toString(),
        style: const TextStyle(fontSize: 30),
      );
}

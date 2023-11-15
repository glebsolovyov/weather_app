import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  const Temperature({super.key, required this.data});

  final int data;

  @override
  Widget build(BuildContext context) => Text(
        data.toString(),
        style: const TextStyle(fontSize: 50),
      );
}
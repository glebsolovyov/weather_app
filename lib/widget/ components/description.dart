import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) => Text(
    data.toString(),
    style: const TextStyle(fontSize: 20)
    );
}
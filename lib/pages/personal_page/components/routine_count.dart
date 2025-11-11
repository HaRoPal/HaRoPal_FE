import 'package:flutter/material.dart';

class RoutineCount extends StatelessWidget {
  final String text;
  final int count;
  final int exp;
  const RoutineCount({super.key, required this.text, required this.count, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          '$count회 (${exp}xp)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

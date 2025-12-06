import 'package:flutter/material.dart';

class ExerciseNameAndIcon extends StatelessWidget {
  final String exerciseName;
  final String iconPath;
  const ExerciseNameAndIcon({super.key, required this.exerciseName, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Text(exerciseName),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset(
                iconPath,
                width: 20,
                errorBuilder: (_, __, ___) => SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

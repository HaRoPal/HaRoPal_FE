import 'exercise.dart';

class WorkoutRoutine {
  final String day;
  final String focus;
  final List<Exercise> exercises;

  WorkoutRoutine({
    required this.day,
    required this.focus,
    required this.exercises,
  });

  factory WorkoutRoutine.fromJson(Map<String, dynamic> json) {
    return WorkoutRoutine(
      day: json["day"],
      focus: json["focus"],
      exercises: (json["exercises"] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
    );
  }
}
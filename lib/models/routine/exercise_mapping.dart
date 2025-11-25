class ExerciseMapping {
  final String exerciseName;
  final int exerciseId;
  final int routineExerciseId;
  final int dayNumber;
  final int orderInDay;

  ExerciseMapping({
    required this.exerciseName,
    required this.exerciseId,
    required this.routineExerciseId,
    required this.dayNumber,
    required this.orderInDay,
  });

  factory ExerciseMapping.fromJson(Map<String, dynamic> json) {
    return ExerciseMapping(
      exerciseName: json["exercise_name"],
      exerciseId: json["exercise_id"],
      routineExerciseId: json["routine_exercise_id"],
      dayNumber: json["day_number"],
      orderInDay: json["order_in_day"],
    );
  }
}
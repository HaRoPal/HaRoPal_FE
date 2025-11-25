import 'workout_routine.dart';
import 'exercise_mapping.dart';

class WorkoutRoutineResponse {
  final bool success;
  final String? responseType;
  final String? message;
  final List<WorkoutRoutine> routine;
  final String notes;
  final int expectedKcal;
  final int routineId;
  final List<ExerciseMapping> exerciseMappings;
  final String? error;

  WorkoutRoutineResponse({
    required this.success,
    required this.responseType,
    required this.message,
    required this.routine,
    required this.notes,
    required this.expectedKcal,
    required this.routineId,
    required this.exerciseMappings,
    required this.error,
  });

  factory WorkoutRoutineResponse.fromJson(Map<String, dynamic> json) {
    return WorkoutRoutineResponse(
      success: json["success"],
      responseType: json["response_type"],
      message: json["message"],
      routine: (json["routine"] as List)
          .map((e) => WorkoutRoutine.fromJson(e))
          .toList(),
      notes: json["notes"],
      expectedKcal: json["expected_kcal"],
      routineId: json["routine_id"],
      exerciseMappings: (json["exercise_mappings"] as List)
          .map((e) => ExerciseMapping.fromJson(e))
          .toList(),
      error: json["error"],
    );
  }
}
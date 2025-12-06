import 'package:get/get.dart';

import '../models/routine/exercise_mapping.dart';
import '../models/routine/workout_routine.dart';

class RoutineController extends GetxController {
  final routines = <WorkoutRoutine>[].obs;
  final routineId = RxnInt();
  final workoutLogId = RxnInt();
  final todayDayNumber = RxnInt();
  WorkoutRoutine? todayRoutine;

  // exercise_mappings 저장
  final exerciseMappings = <ExerciseMapping>[].obs;

  void saveRoutine({
    required List<dynamic> routineJson,
    required int id,
    required List<dynamic> mappingJson,
  }) {
    routineId.value = id;

    routines.assignAll(
      routineJson.map((e) => WorkoutRoutine.fromJson(e)).toList(),
    );

    todayRoutine = routines.isNotEmpty ? routines[0] : null;

    exerciseMappings.assignAll(
      mappingJson.map((e) => ExerciseMapping.fromJson(e)).toList(),
    );
  }

  void clearRoutine() {
    routineId.value = null;
    workoutLogId.value = null;
    routines.clear();
    exerciseMappings.clear();
  }
}
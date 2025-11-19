import 'package:get/get.dart';
import '../models/workout_routine.dart';

class RoutineController extends GetxController {
  final routines = <WorkoutRoutine>[].obs;

  // today’s routine (Day 1 기준)
  WorkoutRoutine? get todayRoutine {
    if (routines.isEmpty) return null;
    return routines.first;  // Day1만 가져오거나
  }

  // 저장하는 함수
  void saveRoutine(List<dynamic> jsonList) {
    final parsed = jsonList.map((e) => WorkoutRoutine.fromJson(e)).toList();
    routines.assignAll(parsed);
  }
}
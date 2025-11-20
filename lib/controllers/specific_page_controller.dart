import 'package:get/get.dart';

import '../services/http/community/get_category.dart';
import '../services/http/community/specific_workout.dart';

class SpecificPageController extends GetxController {
  RxMap<String, dynamic> specificWorkout = <String, dynamic>{}.obs;
  RxInt logId = 0.obs;
  RxBool isLoading = false.obs;

  Future<void> fetchSpecificWorkoutFromCategory(String categoryName) async {
    isLoading.value = true;
    final tempData = await getCategory(categoryName);
    logId.value = tempData['workouts'][0]['log_id'];
    final rawData = await getSpecificWorkout(logId.value);
      final title = rawData['workout']['routine']['title'];
      final kcal = rawData['workout']['kcal'];
      final totalTime = rawData['workout']['total_time'];
      final category = rawData['workout']['routine']['category'];
      final expectedTime = rawData['workout']['routine']['expectedTime'];

      specificWorkout.value = {
        'title': title,
        'kcal': kcal,
        'totalTime': totalTime,
        'category': category,
        'expectedTime': expectedTime
      };
      isLoading.value = false;
  }

  Future<void> fetchSpecificWorkout() async {
    isLoading.value = true;
    final rawData = await getSpecificWorkout(logId.value);
    print(rawData);
    final title = rawData['workout']['routine']['title'];
    final kcal = rawData['workout']['kcal'];
    final totalTime = rawData['workout']['total_time'];
    final category = rawData['workout']['routine']['category'];
    final expectedTime = rawData['workout']['routine']['expectedTime'];

    specificWorkout.value = {
      'title': title,
      'kcal': kcal,
      'totalTime': totalTime,
      'category': category,
      'expectedTime': expectedTime
    };

    isLoading.value = false;
  }
}
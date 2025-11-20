import 'package:get/get.dart';

import '../services/http/community/get_recent.dart';
import '../services/http/community/get_similar.dart';

class CommunityController extends GetxController {
  RxList<Map<String, dynamic>> totalRecommendedWorkout = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> totalRecentWorkout = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      await fetchSimilar();
      await fetchRecent();
    } catch (e) {
      print("CommunityControllerError: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSimilar() async {
    final rawData = await getSimilar();
    print(rawData);
    final recommendedWorkoutCount = rawData['workouts'].length;

    for (int i = 0; i < recommendedWorkoutCount; i++) {
      final nickname = rawData['workouts'][i]['user']['nickname'];
      final id = rawData['workouts'][i]['log_id'];
      final category = rawData['workouts'][i]['routine']['category'];
      final kcal = rawData['workouts'][i]['kcal'];
      final satisfaction = rawData['workouts'][i]['satisfaction'];
      final height = rawData['workouts'][i]['user']['height'];
      final weight = rawData['workouts'][i]['user']['weight'];
      final totalTime = rawData['workouts'][i]['total_time'];
      final formData = {
        "nickname": nickname,
        "id": id,
        "category": category,
        "kcal": kcal,
        "satisfaction": satisfaction,
        "height": height,
        "weight": weight,
        "totalTime": totalTime,
      };
      totalRecommendedWorkout.add(formData);
    }
  }

  Future<void> fetchRecent() async {
    final rawData = await getRecent();
    print(rawData);
    final recentWorkoutCount = rawData['workouts'].length;

    for (int i = 0; i < recentWorkoutCount; i++) {
      final nickname = rawData['workouts'][i]['user']['nickname'];
      final id = rawData['workouts'][i]['log_id'];
      final category = rawData['workouts'][i]['routine']['category'];
      final kcal = rawData['workouts'][i]['kcal'];
      final satisfaction = rawData['workouts'][i]['satisfaction'];
      final height = rawData['workouts'][i]['user']['height'];
      final weight = rawData['workouts'][i]['user']['weight'];
      final totalTime = rawData['workouts'][i]['total_time'];
      final formData = {
        "nickname": nickname,
        "id": id,
        "category": category,
        "kcal": kcal,
        "satisfaction": satisfaction,
        "height": height,
        "weight": weight,
        "totalTime": totalTime,
      };
      totalRecentWorkout.add(formData);
    }
  }

  Future<void> disposeController() async {
    totalRecommendedWorkout.value = <Map<String, dynamic>>[].obs;
    totalRecentWorkout.value = <Map<String, dynamic>>[].obs;
  }
}
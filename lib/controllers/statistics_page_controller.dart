import 'dart:math';

import 'package:get/get.dart';

import '../services/http/users/get_recent_workout.dart';

class StatisticsPageController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt totalCount = 0.obs;
  RxList<Map<String, dynamic>> myRecentWorkout = <Map<String, dynamic>>[].obs;

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      await fetchMyRecentWorkout();
    } catch (e) {
     print("StatisticsPageController Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyRecentWorkout() async {
    final rawData = await getRecentWorkout();
    totalCount.value = rawData['totalCount'];
    for (int i = 0; i < totalCount.value; i++) {
      final logId = rawData['items'][i]['workoutLogId'];
      final title = rawData['items'][i]['title'];
      final duration = rawData['items'][i]['durationMinutes'];
      final kcal = rawData['items'][i]['burnedKcal'];
      final rating = rawData['items'][i]['rating'];

      final formData = {
        'logId': logId,
        'title': title,
        'duration': duration,
        'kcal': kcal,
        'rating': rating,
      };
      myRecentWorkout.add(formData);
    }
  }
}
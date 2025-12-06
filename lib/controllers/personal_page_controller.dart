import 'package:get/get.dart';

import '../services/http/exp/get_exp.dart';
import '../services/http/users/get_workout_dates.dart';

class PersonalPageController extends GetxController {
  RxBool isLoading = false.obs;
  RxString nickname = "".obs;
  RxInt level = 0.obs;
  RxInt totalExp = 0.obs;
  RxInt remainingExp = 0.obs;
  RxInt nextLevelExp = 0.obs;
  RxInt completedCount = 0.obs;
  RxInt completedExp = 0.obs;
  RxInt sharedCount = 0.obs;
  RxInt sharedExp = 0.obs;

  RxInt totalWorkoutDay = 0.obs;
  RxList<List<int>> filteredWorkoutList = <List<int>>[].obs;

   Future<void> fetchData() async {
     isLoading.value = true;
     try {
       await fetchExp();
       await fetchDates();
     } catch (e) {
       print("PersonalPageError: $e");
     } finally {
       isLoading.value = false;
     }
   }

   Future<void> fetchExp() async {
     final rawData = await getExp();
     nickname.value = rawData['nickname'] ?? "";
     level.value = rawData['level'] ?? 0;
     totalExp.value = rawData['total_exp'] ?? 0;
     remainingExp.value = rawData['remaining_exp'] ?? 0;
     nextLevelExp.value = rawData['next_level_exp'] ?? 0;
     completedCount.value = rawData['completed_count'] ?? 0;
     completedExp.value = rawData['completed_exp'] ?? 0;
     sharedCount.value = rawData['shared_count'] ?? 0;
     sharedExp.value = rawData['shared_exp'] ?? 0;
   }

   Future<void> fetchDates() async {
     final rawData = await getWorkoutDates();
     totalWorkoutDay.value = rawData['dates'].length;
     final List<String> totalWorkoutList = List<String>.from(rawData['dates']);
     filteredWorkoutList.value = splitDateList(totalWorkoutList);
   }

  List<List<int>> splitDateList(List<String> dateList) {
    return dateList.map((date) {
      final parts = date.split('-');
      return parts.map(int.parse).toList();
    }).toList();
  }
}
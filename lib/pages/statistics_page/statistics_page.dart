import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/controllers/specific_page_controller.dart';
import 'package:haropal/pages/specific_statistics_page/specific_statistics_page.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import '../../controllers/statistics_page_controller.dart';
import '../loading_page/loading_page.dart';
import 'components/exercise_graph.dart';
import 'components/latest_exercise.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final controller = Get.find<StatisticsPageController>();

  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value ? LoadingPage() :
      Scaffold(
        appBar: AppBarWithTitleAndHamburger(title: '통계'),
        drawer: Hamburger(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "통계",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                  child: Text(
                    '지난 운동 기록',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Row(
                    children: [
                      Icon(Icons.explore_outlined, color: Color(0xFF73787B),),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          '${controller.totalCount.value}개의 기록',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.5,
                              color: Color(0xFF73787B)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          for (int i = 0; i < controller.totalCount.value; i++)
                          GestureDetector(
                            onTap: () {
                              final specificController = Get.find<SpecificPageController>();
                              specificController.logId.value = controller.myRecentWorkout[i]['logId'];
                              specificController.fetchSpecificWorkout();
                              Get.to(() => SpecificStatisticsPage());
                            },
                            child: LatestExercise(
                              title: controller.myRecentWorkout[i]['title'],
                              workoutTime: controller.myRecentWorkout[i]['duration'],
                              kcal: controller.myRecentWorkout[i]['kcal'],
                              rating: controller.myRecentWorkout[i]['rating'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width - 20,
                    child: ExerciseGraph(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../../components/button/bottom_navigation_bar_button.dart';
import '../../../components/hamburger/hamburger.dart';
import '../../controllers/specific_page_controller.dart';
import '../loading_page/loading_page.dart';
import 'components/exercise_name_and_icon.dart';

class SpecificStatisticsPage extends StatelessWidget {
  const SpecificStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpecificPageController>();
    return Obx(() {
      return controller.isLoading.value ? LoadingPage() :
      Scaffold(
        appBar: AppBarWithTitleAndHamburger(title: '통계'),
        drawer: Hamburger(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFF2F8FF),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          controller.specificWorkout['title'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006BE5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text(
                          '소모된 칼로리',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        '${controller.specificWorkout['kcal']}kcal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color(0xFF006BE5)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          "운동 시간 · ${controller.specificWorkout['totalTime']}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ExerciseNameAndIcon(
                              exerciseName: controller.specificWorkout['category'],
                              iconPath: 'assets/images/exercise/${controller.specificWorkout['category']}.png',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          '운동 상세',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F8FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "토요일 주간 루틴 운동",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF006BE5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                            child: Text(
                              '웨이트 기구 필요 · 약 1시간 소요',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ExerciseNameAndIcon(exerciseName: '덤벨 컬', iconPath: 'assets/images/exercise/muscle.png'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0 , 30),
                            child: Text("여기에는 설명이 들어갑니다"),
                          ),
                          Row(
                            children: [
                              ExerciseNameAndIcon(exerciseName: '덤벨 컬', iconPath: 'assets/images/exercise/muscle.png'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0 , 30),
                            child: Text("여기에는 설명이 들어갑니다"),
                          ),
                          Row(
                            children: [
                              ExerciseNameAndIcon(exerciseName: '덤벨 컬', iconPath: 'assets/images/exercise/muscle.png'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0 , 30),
                            child: Text("여기에는 설명이 들어갑니다"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarButton(
            buttonName: '돌아가기',
            onPressed: () {
              Get.back();
            }),
      );
    });
  }
}

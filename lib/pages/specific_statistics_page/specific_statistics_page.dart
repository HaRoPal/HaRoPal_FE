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
    final width = MediaQuery.of(context).size.width;
    print(width);
    return Obx(() {
      if (controller.isLoading.value) {
        return LoadingPage();
      }

      final data = controller.specificWorkout;

      if (data == null ||
          data['exercises'] == null ||
          data['exercises'] is! List ||
          (data['exercises'] as List).isEmpty) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithTitleAndHamburger(title: '통계'),
          drawer: Hamburger(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "해당 운동 데이터가 존재하지 않습니다.",
                  style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
                ),
                Text(
                  "다른 카테고리 혹은 루틴을 선택해주세요!",
                  style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBarButton(
            buttonName: '돌아가기',
            onPressed: () => Get.back(),
          ),
        );
      }
      return Scaffold(
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
                        padding: const EdgeInsets.all(20),
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
                        padding: const EdgeInsets.only(top: 20.0),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              controller.specificWorkout['title'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF006BE5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...[
                            for (int i = 0; i < controller.specificWorkout['exercises'].length; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                              controller.specificWorkout['exercises'][i]['name'],
                                            style: TextStyle(
                                              fontSize: 17.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                            controller.specificWorkout['exercises'][i]['exercise_note'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ]
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

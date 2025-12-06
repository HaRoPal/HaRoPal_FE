import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import '../../controllers/personal_page_controller.dart';
import '../loading_page/loading_page.dart';
import 'components/personal_information.dart';
import 'components/routine_count.dart';
import 'components/streak_calendar.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final controller = Get.find<PersonalPageController>();

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
        appBar: const AppBarWithTitleAndHamburger(title: '개인 정보'),
        drawer: const Hamburger(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36),
            child: Obx(() {
              return Column(
                children: [
                  PersonalInformation(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Text(
                          '이번 달 ${controller.totalWorkoutDay.value}일 만큼 운동하셨어요!🔥',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: StreakCalendar(),
                  ),
                  RoutineCount(
                    text: '루틴 완료 횟수',
                    count: controller.completedCount.value,
                    exp: controller.completedExp.value,
                  ),
                  RoutineCount(
                    text: '기록 공유 횟수',
                    count: controller.sharedCount.value,
                    exp: controller.sharedExp.value,
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streak_calendar/streak_calendar.dart';

import '../../../controllers/personal_page_controller.dart';

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PersonalPageController>();
    return Obx(() {
      return IgnorePointer(
        ignoring: true,
        child: CleanCalendar(
          headerProperties: HeaderProperties(
              navigatorDecoration: NavigatorDecoration(
                navigateLeftButtonIcon: const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                navigateRightButtonIcon: const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
              )
          ),
          leadingTrailingDatesProperties: DatesProperties(
            disable: true,
            hide: true,
          ),
          generalDatesProperties: DatesProperties(
              datesDecoration: DatesDecoration(
                datesBorderRadius: 1000,
                datesBackgroundColor: Colors.lightGreen.shade100,
                datesBorderColor: Colors.lightGreen.shade100,
              )
          ),
          streakDatesProperties: DatesProperties(
              datesDecoration: DatesDecoration(
                datesBorderRadius: 1000,
                datesBorderColor: Colors.green,
                datesBackgroundColor: Colors.green,
                datesTextColor: Colors.white,
              )
          ),
          datesForStreaks: [
            for (int i = 0; i < controller.filteredWorkoutList.length; i++)
              DateTime(
                controller.filteredWorkoutList[i][0],
                controller.filteredWorkoutList[i][1],
                controller.filteredWorkoutList[i][2],
              ),
          ],
        ),
      );
    });
  }
}

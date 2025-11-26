import 'package:get/get.dart';
import 'package:haropal/controllers/routine_controller.dart';

import 'controllers/community_controller.dart';
import 'controllers/input_information_controller.dart';
import 'controllers/personal_page_controller.dart';
import 'controllers/specific_page_controller.dart';
import 'controllers/statistics_page_controller.dart';

void initControllers() {
  Get.put(CommunityController());
  Get.put(RoutineController());
  Get.put(PersonalPageController());
  Get.put(SpecificPageController());
  Get.put(StatisticsPageController());
  Get.put(InputInformationController());
}

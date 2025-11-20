import 'package:get/get.dart';

import 'controllers/community_controller.dart';
import 'controllers/personal_page_controller.dart';
import 'controllers/specific_page_controller.dart';
import 'controllers/statistics_page_controller.dart';

void initControllers() {
  Get.put(CommunityController());
  Get.put(PersonalPageController());
  Get.put(SpecificPageController());
  Get.put(StatisticsPageController());
}

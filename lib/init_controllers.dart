import 'package:get/get.dart';
import 'package:haropal/controllers/routine_controller.dart';

import 'controllers/community_controller.dart';

void initControllers() {
  Get.put(CommunityController());
  Get.put(RoutineController());
}

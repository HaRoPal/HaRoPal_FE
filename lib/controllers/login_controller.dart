import 'package:get/get.dart';

import '../pages/chat_page/chat_page.dart';
import '../pages/login_page/sign_in_page.dart';
import '../services/http/users/get_recent_workout.dart';

class LoginController extends GetxController {
  Future<void> checkData() async {
    final rawData = await getRecentWorkout();
    if (rawData['items'].isEmpty) {
      Get.to(() => SignInPage());
    } else {
      Get.offAll(() => ChatPage());
    }
  }
}
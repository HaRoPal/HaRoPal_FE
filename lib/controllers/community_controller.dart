import 'package:get/get.dart';

import '../services/community/get_similar.dart';

class CommunityController extends GetxController {
  RxString nickname = ''.obs;
  RxString category = ''.obs;
  RxString kcal = ''.obs;
  RxString satisfaction = ''.obs;

  Future<void> fetchSimilar() async {
    final rawData = await getSimilar();
    nickname.value = rawData[1]['user']['nickname'];
    print(nickname.value);
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/pages/chat_page/chat_page.dart';

import '../services/access_token/save_and_get_access_token.dart.dart';
import '../services/http/users/put_profile.dart';

class InputInformationController extends GetxController {
  TextEditingController ageController = TextEditingController();
  RxString gender = '남자'.obs;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController muscleMassController = TextEditingController();
  TextEditingController bodyFatPercentageController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController bmrController = TextEditingController();
  TextEditingController workoutMinutesController = TextEditingController();

  bool checkData() {
    bool hasRequired = ageController.text.isNotEmpty &&
        gender.value != '' &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        workoutMinutesController.text.isNotEmpty;

    if (!hasRequired) return false;

    List<String> optionalValues = [
      muscleMassController.text,
      bodyFatPercentageController.text,
      bmiController.text,
      bmrController.text,
    ];

    bool allEmpty = optionalValues.every((v) => v.isEmpty);
    bool allFilled = optionalValues.every((v) => v.isNotEmpty);

    if (allEmpty || allFilled) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> sendData() async {
    if (bmiController.text.isEmpty) {
      bmiController.text = '0';
    }
    if (bmrController.text.isEmpty) {
      bmrController.text = '0';
    }
    if (muscleMassController.text.isEmpty) {
      muscleMassController.text = '0';
    }
    if (bodyFatPercentageController.text.isEmpty) {
      bodyFatPercentageController.text = '0';
    }
     bool result = await putProfile(
       age: int.parse(ageController.text),
       gender: gender.value,
       height: int.parse(heightController.text),
       weight: int.parse(weightController.text),
       bmi: int.parse(bmiController.text),
       bmr: int.parse(bmrController.text),
       muscle: int.parse(muscleMassController.text),
       fat: int.parse(bodyFatPercentageController.text),
       desired_exercise_time: int.parse(workoutMinutesController.text),
     );

     if (result) {
       Get.offAll(() => ChatPage());
     } else {
       Get.snackbar(
         '오류 발생!',
         '서버 통신 중 오류가 발생했습니다!',
         backgroundColor: Color(0xFFFFFFFF),
         colorText: Colors.black,
         borderRadius: 12,
         margin: EdgeInsets.all(16),
         snackPosition: SnackPosition.TOP,
         duration: Duration(seconds: 2),
         boxShadows: [
           BoxShadow(
             color: Colors.black26,
             blurRadius: 8,
             offset: Offset(0, 3),
           ),
         ],
       );
     }
  }
}
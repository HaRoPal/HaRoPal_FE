import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appbar/app_bar_with_title_without_hamburger.dart';
import '../../components/button/bottom_navigation_bar_button.dart';
import '../../controllers/input_information_controller.dart';
import '../chat_page/chat_page.dart' show ChatPage;
import 'components/check_box.dart';
import 'components/check_list.dart';

//TODO: Exception Handling for TextField
class InputInformationPage extends StatelessWidget {
  const InputInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InputInformationController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithTitleWithoutHamburger(title: '개인 정보 입력'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '인바디 (InBody) 결과를 필요로 합니다!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("골격근량·체지방률·BMI·BMR의 경우",),
                                    Text("나머지 값만 입력해주시면",),
                                    Text("자동으로 계산해드립니다!\n"),
                                    Text('직접 입력하실 경우에는'),
                                    Text('이 네 가지 값을 모두 입력해야 합니다.')
                                  ],
                                ),
                                insetPadding: EdgeInsets.all(20),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.info_outline,
                          size: 20,
                        ),
                      )
                    ),
                  ],
                ),
              ),
              CheckList(checkName: '나이 : ', checkController: controller.ageController),
              CheckBox(checkName: '성별 : '),
              CheckList(checkName: '키 (cm) : ', checkController: controller.heightController),
              CheckList(checkName: '체중 (kg) : ', checkController: controller.weightController),
              CheckList(checkName: '골격근량 : ', checkController: controller.muscleMassController),
              CheckList(checkName: '체지방률 : ', checkController: controller.bodyFatPercentageController),
              CheckList(checkName: '체지방 지수 (BMI) : ', checkController: controller.bmiController),
              CheckList(checkName: '기초대사량 (BMR) : ', checkController: controller.bmrController),
              CheckList(checkName: '평균 운동 시간 (분) : ', checkController: controller.workoutMinutesController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarButton(
        buttonName: '앱 시작하기',
        onPressed: () {
          if (controller.checkData()) {
            controller.sendData();
          } else {
            Get.snackbar(
              '오류 발생!',
              '입력 필드를 확인해주세요!',
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
        }),
    );
  }
}

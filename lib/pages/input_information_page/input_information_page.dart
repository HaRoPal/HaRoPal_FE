import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appbar/app_bar_with_title_without_hamburger.dart';
import '../../components/button/bottom_navigation_bar_button.dart';
import '../chat_page/chat_page.dart' show ChatPage;
import 'components/check_list.dart';

//TODO: Exception Handling for TextField
class InputInformationPage extends StatelessWidget {
  const InputInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithTitleWithoutHamburger(title: '개인 정보 입력'),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          // TODO: Connect TextEditingController for each CheckList
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                  '인바디 (InBody) 결과를 필요로 합니다!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
            ),
            CheckList(checkName: '체중 (kg) : ', checkController: TextEditingController()),
            CheckList(checkName: '골격근량 : ', checkController: TextEditingController()),
            CheckList(checkName: '체지방률 : ', checkController: TextEditingController()),
            CheckList(checkName: '체지방 지수 (BMI) : ', checkController: TextEditingController()),
            CheckList(checkName: '기초대사량 (BMR) : ', checkController: TextEditingController()),
            CheckList(checkName: '평균 운동 시간 (분) : ', checkController: TextEditingController()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarButton(
        buttonName: '앱 시작하기',
        onPressed: () {
          Get.offAll(() => ChatPage());
        }),
    );
  }
}

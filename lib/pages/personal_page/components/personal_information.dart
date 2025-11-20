import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/personal_page_controller.dart';
import '../../input_information_page/change_information_page.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PersonalPageController>();
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      controller.nickname.value,
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Lv.${controller.level.value}',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0070F0)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.off(() => ChangeInformationPage());
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Color(0xFF909090)
                        ),
                      ),
                    ),
                    child: Text(
                      "개인 정보 수정",
                      style: TextStyle(
                        color: Color(0xFF909090),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          LinearProgressIndicator(
            value: controller.remainingExp.value/controller.totalExp.value,
            backgroundColor: const Color(0xFF80B7F7),
            color: const Color(0xFF0070F0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${controller.remainingExp.value}/${controller.totalExp}xp',
                style: const TextStyle(
                    color: Color(0xFF0070F0)
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}



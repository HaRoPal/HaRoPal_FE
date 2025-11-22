import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:haropal/pages/login_page/start_page.dart';

import '../../../controllers/personal_page_controller.dart';
import '../../../services/http/auth/sign_out.dart';
import '../../input_information_page/change_information_page.dart';
import '../../login_page/sign_in_page.dart';

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
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Lv.${controller.level.value}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0070F0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
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
                              color: Color(0xFF909090),
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
              SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  try {
                    // 1. 로그아웃 API 호출
                    final res = await signOut();

                    // 2. 로그아웃 API 성공 여부 확인
                    if (res['success'] == true) {
                      // 3. SecureStorage의 토큰 삭제
                      await storage.delete(key: 'access_token');
                      await storage.delete(key: 'refresh_token');
                      await storage.delete(key: 'expires_at');

                      // 4. 로그인 페이지로 이동
                      Get.offAll(() => const StartPage());
                    } else {
                      // 실패 시 서버 메시지 표시
                      Get.snackbar(
                        "로그아웃 실패",
                        res['message'] ?? "로그아웃 처리 중 오류가 발생했습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  } catch (e) {
                    // 네트워크 오류 또는 Dio 오류
                    Get.snackbar(
                      "오류",
                      "로그아웃 중 예상치 못한 오류가 발생했습니다.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
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
                              color: Color(0xFF909090),
                            ),
                          ),
                        ),
                        child: Text(
                          "로그아웃",
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
            ],
          ),
          LinearProgressIndicator(
            value: _safeProgress(
              controller.remainingExp.value,
              controller.totalExp.value,
            ),
            backgroundColor: const Color(0xFF80B7F7),
            color: const Color(0xFF0070F0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${controller.remainingExp.value}/${controller.totalExp}xp',
                style: const TextStyle(color: Color(0xFF0070F0)),
              ),
            ],
          ),
        ],
      );
    });
  }

  double _safeProgress(int current, int total) {
    if (total == 0) return 0.0;

    double ratio = current / total;

    if (ratio.isNaN || ratio.isInfinite) {
      return 0.0;
    }
    return ratio.clamp(0.0, 1.0);
  }
}

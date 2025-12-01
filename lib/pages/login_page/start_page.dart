import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    spreadRadius: 2,
                    blurRadius: 6,
                  )
                ]
              ),
              child: Image.asset(
                  'assets/images/icon/gymini_icon.png',
                width: width * 0.8,
              ),
            ),
            Text(
                'AI와 함께하는 운동 메이트',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF0070F0),
                        padding: EdgeInsetsGeometry.symmetric(vertical: 15)
                      ),
                      onPressed: () {
                        Get.to(SignInPage());
                      },
                      child: Text(
                          "로그인",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsetsGeometry.symmetric(vertical: 15),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF9D9D9D)
                      ),
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                      child: Text(
                        "회원 가입",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}

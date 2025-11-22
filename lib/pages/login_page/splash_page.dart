import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haropal/pages/input_information_page/input_information_page.dart';
import 'package:haropal/pages/login_page/start_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final accessToken = await storage.read(key: 'access_token');

    // TODO: 토큰 만료 확인 필요
    if (accessToken != null && accessToken.isNotEmpty) {
      // 토큰 존재 → 자동 로그인
      Get.offAll(() => InputInformationPage());
    } else {
      // 토큰 없음 → 로그인 페이지
      Get.offAll(() => const StartPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haropal/pages/login_page/start_page.dart';

import '../../services/http/auth/get_me.dart';
import '../chat_page/chat_page.dart';

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
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null || accessToken.isEmpty) {
      // 토큰 없음 → 시작 페이지로
      Get.offAll(() => const StartPage());
      return;
    }

    try {
      // 토큰이 있으니 getMe 호출 (토큰 유효한지 검증)
      final me = await getMe();

      // 정상 응답 200대 → 로그인 유지
      Get.offAll(() => ChatPage());

    } on DioException catch (e) {
      final code = e.response?.statusCode;

      // 400~599 응답 → 토큰 무효 또는 서버 오류 → 로그인 페이지로
      if (code != null && code >= 400 && code < 600) {
        Get.offAll(() => const StartPage());
        return;
      }

      // 네트워크 오류 등 statusCode 없음
      Get.offAll(() => const StartPage());
      return;

    } catch (e) {
      // 그 외 모든 예외도 로그인 실패로 처리
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../pages/login_page/terms_page.dart';
import '../../dio/unauthorized_dio.dart';
import 'package:get/get.dart';

const storage = FlutterSecureStorage();

Future<Map<String, dynamic>> signIn({
  required String email,
  required String password,
}) async {
  final dio = await getUnauthorizedDio();

  final body = {
    'email': email,
    'password': password,
  };

  final response = await dio.post(
    'https://haropal-be.onrender.com/auth/signin',
    data: body,
  );

  final data = response.data;

  /// 로그인 성공 시 토큰 저장
  if (data['success'] == true && data['session'] != null) {
    final session = data['session'];

    await storage.write(
      key: 'access_token',
      value: session['access_token'] ?? '',
    );

    await storage.write(
      key: 'refresh_token',
      value: session['refresh_token'] ?? '',
    );

    await storage.write(
      key: 'expires_at',
      value: session['expires_at'].toString(),
    );

    // 약관 동의 여부 확인
    final termsAgreed = await storage.read(key: 'terms_agreed') ?? 'false';

    if (termsAgreed == 'false') {
      // 약관 동의 페이지로 이동
      final result = await Get.to(() => const TermsPage());

      if (result == true) {
        await storage.write(key: 'terms_agreed', value: 'true');
      }
    }
  }

  return data;
}
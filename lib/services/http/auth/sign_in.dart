import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../dio/unauthorized_dio.dart';

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
  }

  return data;
}
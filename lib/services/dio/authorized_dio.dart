import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<Dio> getAuthorizedDio() async {
  final dio = Dio();

  // SecureStorage에서 토큰 불러오기
  final accessToken = await storage.read(key: 'access_token');

  if (accessToken == null || accessToken.isEmpty) {
    throw Exception("No access token found. User must log in.");
  }

  // Authorization 헤더 주입
  dio.options.headers['Authorization'] = 'Bearer $accessToken';
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';

  return dio;
}
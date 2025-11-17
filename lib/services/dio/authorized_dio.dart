import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../access_token/save_and_get_access_token.dart.dart';

Future<Dio> getAuthorizedDio() async {
  final dio = Dio();
  final accessToken = dotenv.env['ACCESS_TOKEN'];
  dio.options.headers = {
    'Authorization': 'Bearer $accessToken',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  return dio;
}

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../dio/authorized_dio.dart';

final storage = const FlutterSecureStorage();

Future<Map<String, dynamic>> signOut() async {
  final dio = await getAuthorizedDio();

  final response = await dio.post(
    'https://haropal-be.onrender.com/auth/signout',
  );

  return response.data;
}
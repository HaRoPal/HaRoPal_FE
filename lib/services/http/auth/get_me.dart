import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haropal/services/dio/authorized_dio.dart';

const storage = FlutterSecureStorage();

Future<Map<String, dynamic>> getMe() async {
  final dio = await getAuthorizedDio();


  final response = await dio.get(
    'https://haropal-be.onrender.com/auth/me',
  );

  return response.data;

}
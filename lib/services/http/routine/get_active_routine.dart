import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getActiveRoutine() async {
  final dio = await getAuthorizedDio();

  final response = await dio.get(
    'https://haropal-be.onrender.com/api/routines/logs/active',
  );

  return response.data;
}
import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getRecentStats() async {
  final dio = await getAuthorizedDio();
  final response = await dio.get('https://haropal-be.onrender.com/users/me/stats/recent');
  return response.data;
}

import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getRecent() async {
  final dio = await getAuthorizedDio();
  final response = await dio.get('https://haropal-be.onrender.com/community/recent/');
  return response.data;
}
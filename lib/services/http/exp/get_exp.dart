import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getExp() async {
  final dio = await getAuthorizedDio();
  final response = await dio.get('https://haropal-be.onrender.com/exp/');
  return response.data;
}
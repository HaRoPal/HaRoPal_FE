
import '../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getSimilar() async {
  final dio = await getAuthorizedDio();
  final response = await dio.get('https://haropal-be.onrender.com/community/similar/');
  return response.data;
}
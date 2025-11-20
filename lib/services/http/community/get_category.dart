import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getCategory(String category) async {
  final dio = await getAuthorizedDio();
  final response = await dio.get(
      'https://haropal-be.onrender.com/community/category/',
    queryParameters: {
        'category': category
    }
  );
  return response.data;
}
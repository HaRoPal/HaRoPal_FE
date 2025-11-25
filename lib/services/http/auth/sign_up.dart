import '../../dio/unauthorized_dio.dart';

Future<Map<String, dynamic>> signup({
  required String email,
  required String password,
  String? name,
}) async {
  final dio = await getUnauthorizedDio();

  final body = {
    'email': email,
    'password': password,
    if (name != null) 'full_name': name,
  };

  final response = await dio.post(
    'https://haropal-be.onrender.com/auth/signup',
    data: body,
  );

  return response.data;
}
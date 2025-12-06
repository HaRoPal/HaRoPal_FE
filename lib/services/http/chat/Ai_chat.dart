

import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> sendAiMessage({
  required String message,
  required List<Map<String, String>> history,
}) async {
  final dio = await getAuthorizedDio();

  final body = {
    'message': message,
    'history': history,
  };

  final response = await dio.post(
    'https://haropal-be.onrender.com/api/ai/chat',
    data: body,
  );

  return response.data;
}
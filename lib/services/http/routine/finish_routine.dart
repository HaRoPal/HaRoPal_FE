import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> finishRoutine({
  required int workoutLogId,
}) async {
  final dio = await getAuthorizedDio();

  final response = await dio.put(
    'https://haropal-be.onrender.com/api/routines/logs/$workoutLogId/finish',
  );

  return response.data;
}
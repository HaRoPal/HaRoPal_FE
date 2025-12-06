import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> startRoutine({
  required int routineId,
}) async {
  final dio = await getAuthorizedDio();

  final response = await dio.post(
    'https://haropal-be.onrender.com/api/routines/$routineId/start',
  );

  return response.data;
}
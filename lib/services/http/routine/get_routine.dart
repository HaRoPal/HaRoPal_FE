import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getRoutineDetail({
  required int routineId,
}) async {
  final dio = await getAuthorizedDio();

  final response = await dio.get(
    'https://haropal-be.onrender.com/api/routines/$routineId',
  );

  return response.data;
}
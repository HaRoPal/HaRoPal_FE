import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> submitRoutineRating({
  required int workoutLogId,
  required int routineSatisfaction,
  required List<Map<String, dynamic>> exerciseRatings,
  required int kcal,
}) async {
  final dio = await getAuthorizedDio();

  final body = {
    "routine_satisfaction": routineSatisfaction,
    "exercise_ratings": exerciseRatings,
    "kcal": kcal,
  };

  final response = await dio.post(
    'https://haropal-be.onrender.com/api/routines/logs/$workoutLogId/rating',
    data: body,
  );

  return response.data;
}
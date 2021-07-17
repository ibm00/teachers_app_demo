import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/api/quiz_api.dart';
import 'package:teachers_app/models/quiz_models.dart';
import 'package:teachers_app/providers/user_data_provider.dart';

final currentQuizProvider = FutureProvider<List<CurrentQuizModel>>((ref) async {
  List temp = await QuizApi.getCurrentQuizes(ref.read(userDataProvider).token);
  return temp.map((e) => CurrentQuizModel.fromMap(e)).toList();
});

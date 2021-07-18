import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/quiz_api.dart';
import '../models/quiz_models.dart';
import 'user_data_provider.dart';

final currentQuizProvider = FutureProvider<List<CurrentQuizModel>>((ref) async {
  List temp = await QuizApi.getCurrentQuizes(ref.read(userDataProvider).token);
  return temp.map((e) => CurrentQuizModel.fromMap(e)).toList();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/api/lessons_api.dart';
import 'package:teachers_app/providers/user_data_provider.dart';

final chaptersProvider = FutureProvider((ref) async =>
    await LessonsApi.getChapters(ref.read(userDataProvider).token));

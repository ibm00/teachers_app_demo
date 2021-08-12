import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/lessons_api.dart';
import 'user_data_provider.dart';

final chaptersProvider = FutureProvider((ref) async =>
    await LessonsApi.getChapters(ref.read(userDataProvider).token));

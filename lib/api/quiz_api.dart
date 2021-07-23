import 'package:http/http.dart' as http;
import 'package:teachers_app/widgets/dialogs/flutter_toast.dart';
import '../constants.dart';
import 'dart:convert';

import '../models/quiz_models.dart';

class QuizApi {
  static Future<List> getCurrentQuizes(String token) async {
    final http.Response response = await http.get(
      Uri.parse('$APP_API/api/quizes/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      throw Exception();
    }
  }

  static Future<String?>? submitQuiz(
      {required String token,
      required int quizId,
      required List<int> answers}) async {
    try {
      http.Response res =
          await http.post(Uri.parse('$APP_API/api/quizes/$quizId/answer/'),
              headers: {
                'Authorization': 'Token $token',
                "Content-Type": "application/json",
              },
              body: json.encode({'answers': answers}));
      Map data = json.decode(res.body) as Map;
      print(data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final int fullMark = double.parse(data['full_mark'] as String).round();
        final int studentMark = double.parse(data['result'] as String).round();
        return 'النتيجة:  $studentMark/$fullMark';
      } else if (res.statusCode == 403) {
        showCustomToast('انت بالفعل قد قمت باجتياز الامتحان');
      } else {
        showCustomToast('فشل تأكيد الحل الرجاء المحاولة مرة اخري');
      }
    } catch (e) {
      print('this is submit quiz error cath $e');
    }
  }
}

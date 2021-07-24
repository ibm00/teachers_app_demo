import 'package:teachers_app/models/quiz_models.dart';

class QuizHelper {
  static List<String> getQuestionAnswers(List<dynamic> q) {
    List<String> l1 = [];
    q.forEach((element) {
      l1.add(element['value'] as String);
    });
    return l1;
  }

  static Map<int, int> matchAnswersWithQuestions(
      List answers, List<QuestionModel> questions) {
    Map<int, int> map = {};
    for (var i = 0; i < questions.length; i++) {
      List l = questions[i].answers;
      for (var k = 0; k < l.length; k++) {}
    }
    return map;
  }
}

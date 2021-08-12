import '../models/quiz_models.dart';

class QuizHelper {
  static List<String> getQuestionAnswersStrings(List<dynamic> q) {
    List<String> l1 = [];
    q.forEach((element) {
      l1.add(element['value'] as String);
    });
    return l1;
  }

  static List<int> getQuestionsAnswersIds(List<dynamic> q) {
    List<int> l1 = [];
    q.forEach((element) {
      l1.add(element['id'] as int);
    });
    return l1;
  }

  static Map<int, int> matchAnswersWithQuestions(
      List answers, List<QuestionModel> questions) {
    int completeAnswersListLength = questions.length - answers.length;
    for (var j = 0; j < completeAnswersListLength; j++) {
      answers.add(-1);
    }
    Map<int, int> map = {};
    for (var i = 0; i < questions.length; i++) {
      List l = questions[i].answers;
      if (answers[i] != -1) {
        for (var k = 0; k < l.length; k++) {
          if (answers[i] == l[k]['id']) {
            map[i] = answers[i] as int;
          }
        }
      }
    }
    print(map);
    return map;
  }
}

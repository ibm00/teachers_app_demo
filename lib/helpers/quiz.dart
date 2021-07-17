class QuizHelper {
  static List<String> getQuestionAnswers(List<dynamic> q) {
    List<String> l1 = [];
    q.forEach((element) {
      l1.add(element['value'] as String);
    });
    return l1;
  }
}

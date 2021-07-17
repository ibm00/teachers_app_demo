import 'package:timeago/timeago.dart' as timeago;
// we have here three type of models
//1- question model
//2- current quiz model
//3- old quiz mddel

//*************************** Question Model *****************************/
class QuestionModel {
  final String title;
  final String image;
  final List answers;
  QuestionModel({
    required this.title,
    required this.image,
    required this.answers,
  });

  factory QuestionModel.fromMap(dynamic map) {
    return QuestionModel(
      title: (map['value'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      answers: map['answers'] as List,
    );
  }
}

//*************************** Current Quiz Model *****************************/
class CurrentQuizModel {
  final int id;
  final String title;
  final String description;
  final String time;
  final List<QuestionModel> questions;
  CurrentQuizModel(
      {required this.id,
      required this.title,
      required this.questions,
      required this.description,
      required this.time});

  factory CurrentQuizModel.fromMap(dynamic map) {
    List l1 = map['questions'] as List;

    return CurrentQuizModel(
      id: map['id'] as int,
      title: (map['title'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      time: timeago.format(DateTime.parse(map['created'] as String),
          locale: 'ar'),
      questions: l1.map((e) => QuestionModel.fromMap(e)).toList(),
    );
  }
}

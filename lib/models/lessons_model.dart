import 'dart:convert';

class LessonModel {
  final String title;
  final String description;
  final List contants;
  final List<LessonQuizModel> quizes;
  LessonModel({
    required this.title,
    required this.description,
    required this.contants,
    required this.quizes,
  });

  factory LessonModel.fromMap(Map map) {
    List q = map['exercises'] as List;
    return LessonModel(
      title: (map['title'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      contants: map['contants'] as List,
      quizes: q.map((e) {
        Map m = e as Map;
        return LessonQuizModel.fromMap(m);
      }).toList(),
    );
  }
}

class LessonQuizModel {
  final String title;
  final String time;
  final String description;
  final List<LessonQuizQuestionModel> questions;
  LessonQuizModel({
    required this.title,
    required this.time,
    required this.description,
    required this.questions,
  });

  factory LessonQuizModel.fromMap(Map map) {
    List q = map['questions'] as List;
    return LessonQuizModel(
      title: (map['title'] ?? "") as String,
      time: (map['time'] ?? "") as String,
      description: (map['description'] ?? "") as String,
      questions: q.map((e) {
        Map m = e as Map;
        return LessonQuizQuestionModel.fromMap(m);
      }).toList(),
    );
  }
}

class LessonQuizQuestionModel {
  final String text;
  final String image;
  final List answers;
  LessonQuizQuestionModel({
    required this.text,
    required this.image,
    required this.answers,
  });

  factory LessonQuizQuestionModel.fromMap(Map map) {
    return LessonQuizQuestionModel(
      text: (map['value'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      answers: map['answers'] as List,
    );
  }
}

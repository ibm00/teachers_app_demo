import 'dart:convert';

class LessonModel {
  final String title;
  final String description;
  final List contants;
  LessonModel({
    required this.title,
    required this.description,
    required this.contants,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'contants': contants,
    };
  }

  factory LessonModel.fromMap(Map map) {
    return LessonModel(
      title: (map['title'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      contants: map['contants'] as List,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/helpers/quiz.dart';
import 'package:teachers_app/providers/quiz_provider.dart';
import 'package:teachers_app/screens/quiz/preview_quiz.dart';

import '../../../components/quiz_card.dart';

class OldQuizesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final futureData = watch(oldQuizProvider);
    return futureData.when(
      data: (value) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, index) => QuizCardComponent(
            isCurrent: false,
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewQuiz(
                      questions: value[index].questions,
                      answers: value[index].answers,
                      examName: value[index].title,
                      matcherMap: QuizHelper.matchAnswersWithQuestions(
                          value[index].answers, value[index].questions),
                    ),
                  ));
            },
            examName: value[index].title,
            text: value[index].description,
            time: value[index].time,
            totalMark: value[index].studentMark,
            studentMark: value[index].fullMark,
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        print('this is old quizes error:$error');
        return const CircularProgressIndicator();
      },
    );
  }
}

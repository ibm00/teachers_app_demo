import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/quiz_provider.dart';
import '../../../providers/user_data_provider.dart';
import '../take_quiz.dart';
import '../../../components/quiz_card.dart';

class CurrentQuizesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final futureProvider = watch(currentQuizProvider);
    return futureProvider.when(
      data: (value) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, index) => QuizCardComponent(
            isCurrent: true,
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakeQuizScreen(
                      questions: value[index].questions,
                      examName: value[index].title,
                    ),
                  ));
            },
            examName: value[index].title,
            text: value[index].description,
            time: value[index].time,
            totalMark: 15,
            studentMark: 20,
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        print('this is current quizes error:$error');
        return const CircularProgressIndicator();
      },
    );
  }
}

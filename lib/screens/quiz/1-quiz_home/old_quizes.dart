import 'package:flutter/material.dart';
import '../../../components/quiz_card.dart';

class OldQuizesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemBuilder: (context, index) => QuizCardComponent(
        isCurrent: false,
        callback: () {},
        examName: 'اسم الامتحان',
        text: 'حد تانى يشير ياعم انا النت عندى مش حلو',
        time: 'السبت , 9 مايو , 2021 الساعه 9:30 مساءا',
        totalMark: 15,
        studentMark: 20,
      ),
    );
  }
}

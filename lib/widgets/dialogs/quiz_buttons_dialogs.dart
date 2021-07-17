import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void quizArrowBackButton(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.BOTTOMSLIDE,
    title: 'أنت علي وشك الخروج من الامتحان',
    //  desc: 'Dialog description here.............',
    btnCancelOnPress: () {
      Navigator.pop(context);
    },
    btnCancelText: 'أعي ذلك',
    btnOkText: 'إلغاء',
    btnOkOnPress: () {},
  )..show();
}

void quizSubmitButton(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'أنت علي وشك إنهاء من الامتحان',
    //  desc: 'Dialog description here.............',
    btnCancelOnPress: () {},
    btnCancelText: 'تراجع',
    btnOkText: 'تأكيد',
    btnOkOnPress: () {},
  )..show();
}

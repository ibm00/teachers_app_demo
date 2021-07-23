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

void showCustomDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  String? okText,
  String? cancelText,
  VoidCallback? okFun,
  VoidCallback? cancelFun,
  required bool allowDissmiss,
}) {
  AwesomeDialog(
    dismissOnTouchOutside: allowDissmiss,
    context: context,
    dialogType: dialogType,
    animType: AnimType.BOTTOMSLIDE,
    title: title,
    //  desc: 'Dialog description here.............',
    btnCancelOnPress: cancelFun,
    btnCancelText: cancelText,
    btnOkText: okText,
    btnOkOnPress: okFun,
  )..show();
}

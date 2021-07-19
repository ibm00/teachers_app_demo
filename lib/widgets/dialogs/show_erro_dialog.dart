import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: message,
    //  desc: 'Dialog description here.............',
    btnCancelOnPress: () {},
    btnCancelText: 'حسنا',
  )..show();
}

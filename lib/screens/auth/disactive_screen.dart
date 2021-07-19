import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/widgets/loading.dart';

import 'login_screen.dart';

class DisActiveScreen extends StatefulWidget {
  const DisActiveScreen({Key? key}) : super(key: key);

  @override
  _DisActiveScreenState createState() => _DisActiveScreenState();
}

class _DisActiveScreenState extends State<DisActiveScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showTheMessage();
  }

  _showTheMessage() async {
    await Future.delayed(Duration(seconds: 1));
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'لم يعد مسموحا لك استخدام التطبيق راجع المدرس لمعرفة السبب',
      //  desc: 'Dialog description here.............',
      btnCancelOnPress: () {
        exit(0);
      },
      btnCancelText: 'غلق التطبيق',
      btnOkText: 'تسجيل الدخول',
      btnOkOnPress: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: LoadingWidgets.getNormalLoading()),
    );
  }
}

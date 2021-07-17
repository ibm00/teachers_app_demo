import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidgets {
  static Widget getNormalLoading() {
    return LottieBuilder.asset('assets/images/l2.json');
  }

  static getDialogLoading(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return getNormalLoading();
      },
    );
  }
}

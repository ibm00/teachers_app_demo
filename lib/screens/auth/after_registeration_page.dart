import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';

class DetectDeviceOreintation extends StatelessWidget {
  final Widget widget;
  const DetectDeviceOreintation({required this.widget});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? widget
        : SingleChildScrollView(
            child: widget,
          );
  }
}

class AfterRegiseterationScreen extends StatelessWidget {
  const AfterRegiseterationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    // 600 pixles stands for tablets or landscape mode
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: DetectDeviceOreintation(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Padding(
                    padding: w > 600
                        ? const EdgeInsets.only(right: 30)
                        : const EdgeInsets.only(right: 0.1),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          },
                          icon: Icon(
                            Icons.close,
                            size: w * 0.07,
                          )),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/creating_acount_message.svg',
                    width: w > 600.0 ? w * 0.7 : w * 0.9,
                  ),
                ],
              ),
              if (or == Orientation.landscape)
                const SizedBox(
                  height: 20,
                ),
              Image.asset(
                'assets/images/waiting_character.png',
                fit: BoxFit.contain,
                width: w > 600.0 ? w * 0.6 : w * 0.8,
              ),
              if (or == Orientation.landscape)
                const SizedBox(
                  height: 20,
                ),
              Text(
                """في حالة عدم تفعيل حسابك يرجي 
التواصل مع المدرس""",
                style: TextStyle(fontSize: w * 0.04, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

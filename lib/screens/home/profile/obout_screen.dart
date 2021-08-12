import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutScreen extends StatelessWidget {
  // static String routeName = 'about-screen';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final w = mediaQuery.width;
    final h = mediaQuery.height;
    final fontSize15 = w * 0.0455;
    final fontSize10 = w * 0.04;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconTheme.of(context),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "حول",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: h * .06,
            ),
            SvgPicture.asset(
              "assets/images/logo1.svg",
              width: w * .45,
            ),
            SizedBox(
              height: h * .04,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "إصدار التطبيق: 1.4.1",
                  style: TextStyle(fontSize: w * 0.035),
                )),
            SizedBox(
              height: h * .06,
            ),
            Padding(
              padding: EdgeInsets.only(right: w * .1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "حول أفــــــــق",
                    style: TextStyle(
                      color: const Color(0xFF4D68D4),
                      fontSize: fontSize15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: h * .01,
                  ),
                  Text(
                    "نتبسنيتب منبي لتن منيبتل \nيستنب يببي سنتيب اسيب ا\n سيعاب سيعبا سعياب تسيتتيتيتشخشسي",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: fontSize10),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * .1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: w * .1),
                  child: Text(
                    "للتواصــــــــل",
                    style: TextStyle(
                      color: const Color(0xFF4D68D4),
                      fontSize: fontSize15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * .04,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: h * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyIcon(
                        fun: () {},
                        iconty: const Icon(
                          Icons.language,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: w * .02,
                      ),
                      MyIcon(
                        fun: () {},
                        iconty: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: w * .02,
                      ),
                      MyIcon(
                          fun: () {},
                          iconty: Image.asset(
                            "assets/images/github.png",
                            width: 24,
                          )),
                      SizedBox(
                        width: w * .02,
                      ),
                      MyIcon(
                          fun: () {},
                          iconty: Image.asset(
                            "assets/images/telegram.png",
                            width: 24,
                          )),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyIcon extends StatelessWidget {
  final Widget iconty;
  final Function fun;
  const MyIcon({required this.iconty, required this.fun});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => fun,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0x0A5464D3),
        ),
      ),
      child: iconty,
    );
  }
}

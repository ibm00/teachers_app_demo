import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'register_screen/register_screen.dart';

class WelcomScreen extends StatelessWidget {
  final TextStyle textStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final orn = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: const Color(0xFF4D68D4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: orn == Orientation.portrait
                ? (mediaQuery.height - MediaQuery.of(context).padding.top)
                : (mediaQuery.width) * 1.1,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/gummy.svg',
                      width: 0.5 *
                          ((orn == Orientation.landscape)
                              ? mediaQuery.height
                              : mediaQuery.width),
                      height: 0.5 *
                          ((orn == Orientation.landscape)
                              ? mediaQuery.height
                              : mediaQuery.width),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: mediaQuery.width * 0.67222,
                    child: Text(
                      "مرحبا بك في التطبيق الخاص\nبالأستاذ رمضان مبروك",
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(
                        fontSize: mediaQuery.width * .04111,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: mediaQuery.width * .5,
                    child: Text(
                      "أكتب الوصف هنا أكتب الوصف هنا أكتب الوصف هنا أكتب الوصف هنا أكتب الوصف هنا ",
                      style: textStyle.copyWith(
                        color: const Color(0x99FFFFFF),
                        fontSize: .028 * mediaQuery.width,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => RegisterScreen()));
                      //context.read(loadingProvider).state = true;
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: mediaQuery.height * .02),
                      child: SvgPicture.asset(
                        'assets/images/button_group.svg',
                        width: 0.1 *
                            ((orn == Orientation.landscape)
                                ? mediaQuery.height
                                : mediaQuery.width),
                        height: 0.19 *
                            ((orn == Orientation.landscape)
                                ? mediaQuery.height
                                : mediaQuery.width),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

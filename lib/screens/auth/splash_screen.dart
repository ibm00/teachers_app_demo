import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final w = mediaQuery.width;
    // final h = mediaQuery.height;
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          Phoenix.rebirth(context);
        },
        child: Stack(
          children: [
            ListView(),
            Center(
                child: SvgPicture.asset(
              'assets/images/logo1.svg',
              width: w * .6,
            )),
          ],
        ),
      )),
    );
  }
}

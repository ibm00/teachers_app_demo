import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teachers_app/widgets/loading.dart';
import '../auth/welcom_screen.dart';
import 'profile/profile_screen.dart';
import '../quiz/1-quiz_home/quiz_home.dart';
import 'news_part.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(h, w, or, context),
            SizedBox(
              height: h * 0.02,
            ),

            Text(
              ',مرحبا عبعال',
              style: TextStyle(fontSize: w * 0.1, fontWeight: FontWeight.w600),
            ),
            Text(
              'كيف يمكننا مساعدتك اليوم ؟',
              style: TextStyle(
                fontSize: w * 0.07,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            // _buildNewsPart(h, w, or),
            NewsPartScreen(),
            SvgPicture.asset(
              'assets/images/blue_home_screen_bar.svg',
              width: w * 0.7,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => QuizHomeScreen()));
              },
              child: SvgPicture.asset(
                'assets/images/quizes_home_screen_card.svg',
                width: w * 0.95,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/images/lessons_home_screen_card.svg',
                width: w * 0.95,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildAppBar(
      double h, double w, Orientation or, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => QrCodeScanScreen()));
            },
            child: SvgPicture.asset(
              'assets/images/barcode_icon.svg',
              width: w * 0.08,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.topToBottom,
                      curve: Curves.bounceIn,
                      child: ProfileScreen()));
            },
            child: SvgPicture.asset(
              'assets/images/menu_icon.svg',
              width: w * 0.1,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/images/notification_icon.svg',
            width: w * 0.1,
          ),
        ],
      ),
    );
  }
}

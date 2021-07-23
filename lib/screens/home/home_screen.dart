import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teachers_app/screens/home/qr_scan_page.dart';

import '../../helpers/video_helper.dart';
import '../lessions/lesson_detail/video/video_preview.dart';
import '../quiz/1-quiz_home/quiz_home.dart';
import 'news_part.dart';
import 'profile/profile_screen.dart';

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrCodeScanScreen(),
                  ));
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
          GestureDetector(
            onTap: () {
              Map map = VideoHelper.getValidUrlForVideo(
                  'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VideoPreviewScreen(
                            url: map['url'] as String,
                            isYouTube: map['isYouTube'] as bool,
                          )));
            },
            child: SvgPicture.asset(
              'assets/images/notification_icon.svg',
              width: w * 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

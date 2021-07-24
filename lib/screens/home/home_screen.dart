import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teachers_app/providers/user_data_provider.dart';
import 'package:teachers_app/services/qr_service.dart';
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

            Consumer(
              builder: (context, watch, child) {
                final provider = watch(userDataProvider);
                return Text(
                  provider.fullName,
                  style:
                      TextStyle(fontSize: w * 0.1, fontWeight: FontWeight.w600),
                );
              },
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
              String? result = await QrServices.scanQR();
              print('result:$result');
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
                  'https://www.youtube.com/watch?v=QLcGs-eosOE&list=RDQLcGs-eosOE&start_radio=1&ab_channel=Nota-%D9%86%D9%88%D8%AA%D9%87');
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

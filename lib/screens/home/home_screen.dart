import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teachers_app/api/auth_api.dart';
import 'package:teachers_app/providers/user_data_provider.dart';
import 'package:teachers_app/screens/lessions/lesson_home.dart';
import 'package:teachers_app/services/qr_service.dart';
import 'package:teachers_app/widgets/dialogs/flutter_toast.dart';
import '../../helpers/video_helper.dart';
import '../lessions/lesson_detail/video/video_preview.dart';
import '../quiz/1-quiz_home/quiz_home.dart';
import 'news_part.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  String getUserFirstName(String n) {
    String name = '';
    List<String> l = n.split(' ');
    name = l.first;
    return name.length > 10 ? name.substring(0, 9) : name;
  }

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
                  "مرحبا " + getUserFirstName(provider.fullName),
                  style:
                      TextStyle(fontSize: w * 0.1, fontWeight: FontWeight.w600),
                );
              },
            ),
            Text(
              'كيف يمكننا مساعدتك اليوم ؟',
              style: TextStyle(
                fontSize: w * 0.06,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            // _buildNewsPart(h, w, or),
            NewsPartScreen(),
            RepaintBoundary(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => QuizHomeScreen()));
                },
                child: SvgPicture.asset(
                  'assets/images/quizes_home_screen_card.svg',
                  width: w * 0.95,
                ),
              ),
            ),

            RepaintBoundary(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => LessionsHomeScreen()));
                },
                child: SvgPicture.asset(
                  'assets/images/lessons_home_screen_card.svg',
                  width: w * 0.95,
                ),
              ),
            ),

            //  Stack(
            //   fit: StackFit.expand,
            //   children: [
            //     Container(
            //       height: 200,
            //       decoration: BoxDecoration(
            //         color: Color(0xFF383D41),
            //         borderRadius: BorderRadius.circular(20),
            //       ),

            //     ),

            //   ],
            // ),
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
              if (result != null && result != '-1') {
                String message = await AuthAPI.confirmAttendance(
                    context.read(userDataProvider).token, result);
                showCustomToast(message);
              }
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
            onTap: () {},
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

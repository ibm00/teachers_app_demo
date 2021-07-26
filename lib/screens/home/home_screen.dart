import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teachers_app/api/auth_api.dart';
import 'package:teachers_app/models/video_model.dart';
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
                  'مرحبا,' + getUserFirstName(provider.fullName),
                  style: TextStyle(
                      fontSize: w * 0.08, fontWeight: FontWeight.w600),
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
              height: h * 0.01,
            ),
            NewsPartScreen(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => QuizHomeScreen(),
                  ),
                );
              },
              child: HomeListMember(
                w: w,
                itemColor: const Color(0xFF4C66D5),
                title: "الإمتحانات",
                des: "آخر التدريبات والامتحانات\nالمضافة",
                path: "assets/images/test.png",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => LessionsHomeScreen(),
                  ),
                );
              },
              child: HomeListMember(
                w: w,
                itemColor: const Color(0xFF383D41),
                title: "الدروس",
                des: "شاهد آخر الدروس المضافه",
                path: "assets/images/read.png",
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
              if (result != null && result != '-1') {
                String message = await AuthAPI.confirmAttendance(
                    context.read(userDataProvider).token, result);
                showCustomToast(message);
              }
            },
            child: RepaintBoundary(
              child: SvgPicture.asset(
                'assets/images/barcode_icon.svg',
                width: w * 0.08,
              ),
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
            child: RepaintBoundary(
              child: SvgPicture.asset(
                'assets/images/menu_icon.svg',
                width: w * 0.1,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {},
            child: RepaintBoundary(
              child: SvgPicture.asset(
                'assets/images/notification_icon.svg',
                width: w * 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListMember extends StatelessWidget {
  const HomeListMember({
    required this.w,
    required this.itemColor,
    required this.title,
    required this.des,
    required this.path,
  });

  final double w;
  final Color itemColor;
  final String title;
  final String des;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: itemColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: w * 0.95,
            height: w * 0.377,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Image.asset(
                  path,
                  width: w * 0.3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      des,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0x80FFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

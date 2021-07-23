import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teachers_app/models/lessons_model.dart';

import '../../../components/quiz_card.dart';
import '../../../constants.dart';
import '../../../providers/indices_provider.dart';
import 'attachment/attachment_widget.dart';
import 'video/video_card.dart';

class LessonDetailScreen extends StatelessWidget {
  final LessonModel lessonModel;
  const LessonDetailScreen({
    required this.lessonModel,
  });
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: Text(
          lessonModel.title,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10),
              child: Consumer(
                builder: (context, watch, child) {
                  final index = watch(lessonDetailIndex).state;
                  return SizedBox(
                    width: w * 0.8,
                    height: or == Orientation.landscape ? h * 0.2 : h * 0.08,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double rowW = constraints.maxWidth;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTabBarItem(
                              callback: () {
                                context.read(lessonDetailIndex).state = 4;
                              },
                              isSelected: index == 4,
                              text: 'التدريبات',
                              width: rowW,
                              borderShape: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            _buildTabBarItem(
                              callback: () {
                                context.read(lessonDetailIndex).state = 3;
                              },
                              isSelected: index == 3,
                              text: 'الفيديوهات',
                              width: rowW,
                            ),
                            _buildTabBarItem(
                              callback: () {
                                context.read(lessonDetailIndex).state = 2;
                              },
                              isSelected: index == 2,
                              text: 'الملحقات',
                              width: rowW,
                            ),
                            _buildTabBarItem(
                              callback: () {
                                context.read(lessonDetailIndex).state = 1;
                              },
                              isSelected: index == 1,
                              text: 'الكل',
                              width: rowW,
                              borderShape: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            AttachmentWidget(
              isPdf: true,
            ),
            AttachmentWidget(
              isPdf: false,
              imageUrl:
                  'https://cf.bstatic.com/xdata/images/hotel/max1024x768/268357210.jpg?k=d9a946b1950b74dfb3278f8ec8870cf79089c2c127f424ee543eb98b2b859c62&o=&hp=1',
            ),
            VideoCardWidget(),
            Padding(
              padding: EdgeInsets.only(
                  left: w * 0.07, right: w * 0.07, top: h * 0.01),
              child: QuizCardComponent(
                isCurrent: true,
                callback: () {},
                examName: 'اسم الامتحان',
                text: 'حد تانى يشير ياعم انا النت عندى مش حلو',
                time: 'السبت , 9 مايو , 2021 الساعه 9:30 مساءا',
                totalMark: 15,
                studentMark: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarItem({
    required VoidCallback callback,
    required bool isSelected,
    required double width,
    BorderRadius? borderShape,
    required String text,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Material(
        elevation: isSelected ? 5 : 0,
        borderRadius: borderShape,
        child: SizedBox(
          width: width / 4,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: width * 0.045,
                color: isSelected ? const Color(0xFF5464D3) : Colors.grey),
          ),
        ),
      ),
    );
  }
}

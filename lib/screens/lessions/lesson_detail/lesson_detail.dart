import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teachers_app/models/lessons_model.dart';
import 'package:teachers_app/screens/lessions/lesson_detail/take_exercises.dart';

import '../../../components/quiz_card.dart';
import '../../../constants.dart';
import '../../../providers/indices_provider.dart';
import 'attachment/attachment_widget.dart';
import 'video/video_card.dart';

class LessonDetailScreen extends StatefulWidget {
  final LessonModel lessonModel;
  const LessonDetailScreen({
    required this.lessonModel,
  });

  @override
  _LessonDetailScreenState createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  List<Map> _attachments = [];
  List<Map> _videos = [];
  @override
  void initState() {
    super.initState();
    widget.lessonModel.contants.forEach((element) {
      Map m = element as Map;
      if (m['type'] == 'video') {
        _videos.add(m);
      } else {
        _attachments.add(m);
      }
    });
  }

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
          widget.lessonModel.title,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              context.read(lessonDetailIndex).state = 1;

              Navigator.pop(context);
            },
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
            Consumer(
              builder: (context, watch, child) {
                int x = watch(lessonDetailIndex).state;
                if (x == 3) {
                  return Column(
                    children: [
                      if (_videos.isNotEmpty)
                        ..._videos
                            .map((e) => VideoCardWidget(
                                title: e['title'] as String,
                                videoUrl: e['item'] as String))
                            .toList(),
                    ],
                  );
                } else if (x == 2) {
                  return Column(
                    children: [
                      if (_attachments.isNotEmpty)
                        ..._attachments.map((e) {
                          return AttachmentWidget(
                            isPdf: e['type'] == 'pdf',
                            title: (e['title'] ?? '') as String,
                            imageUrl: (e['item'] ?? '') as String,
                            pdfUrl: (e['item'] ?? '') as String,
                          );
                        }).toList(),
                    ],
                  );
                } else if (x == 1) {
                  return Column(
                    children: [
                      if (_attachments.isNotEmpty)
                        ..._attachments.map((e) {
                          return AttachmentWidget(
                            isPdf: e['type'] == 'pdf',
                            title: (e['title'] ?? '') as String,
                            imageUrl: (e['item'] ?? '') as String,
                            pdfUrl: (e['item'] ?? '') as String,
                          );
                        }).toList(),
                      if (_videos.isNotEmpty)
                        ..._videos
                            .map((e) => VideoCardWidget(
                                title: e['title'] as String,
                                videoUrl: e['item'] as String))
                            .toList(),
                      Column(
                        children: widget.lessonModel.quizes
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                    left: w * 0.07,
                                    right: w * 0.07,
                                    top: h * 0.01),
                                child: QuizCardComponent(
                                  isCurrent: true,
                                  callback: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TakeExerciseScreen(
                                            examName: e.title,
                                            questions: e.questions,
                                          ),
                                        ));
                                  },
                                  examName: e.title,
                                  text: e.description,
                                  time: e.time,
                                  totalMark: 15,
                                  studentMark: 20,
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  );
                }
                return Column(
                  children: widget.lessonModel.quizes
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(
                              left: w * 0.07, right: w * 0.07, top: h * 0.01),
                          child: QuizCardComponent(
                            isCurrent: true,
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TakeExerciseScreen(
                                      examName: e.title,
                                      questions: e.questions,
                                    ),
                                  ));
                            },
                            examName: e.title,
                            text: e.description,
                            time: e.time,
                            totalMark: 15,
                            studentMark: 20,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
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

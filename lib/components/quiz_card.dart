import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizCardComponent extends StatelessWidget {
  final String examName;
  final String time;
  final String text;
  final VoidCallback callback;
  final bool isCurrent;
  final int studentMark;
  final int totalMark;
  const QuizCardComponent({
    required this.examName,
    required this.time,
    required this.text,
    required this.callback,
    required this.isCurrent,
    required this.studentMark,
    required this.totalMark,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Container(
      width: w * 0.9,
      height: w * 0.6,
      margin: EdgeInsets.symmetric(horizontal: w * 0.03),
      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double newH = constraints.maxHeight;
          double newW = constraints.maxWidth;
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // this is placeholder notice the text colot is white
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '15',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: newW * 0.06),
                          ),
                          Text(
                            "/" + '20',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: newW * 0.06),
                          )
                        ],
                      ),
                      // End of PlaceHolder
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            examName,
                            style: TextStyle(
                              fontSize: newW * 0.08,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                                fontSize: newW * 0.03, color: Colors.grey),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/images/quiz_icon.svg',
                        width: newW * 0.25,
                      ),
                    ],
                  ),
                  Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: newW * 0.05, color: const Color(0xFF2F3C4E)),
                  ),
                  SizedBox(
                    height: newH * 0.05,
                  ),
                  GestureDetector(
                    onTap: callback,
                    child: SvgPicture.asset(
                      isCurrent
                          ? 'assets/images/start_quiz.svg'
                          : 'assets/images/show_quiz.svg',
                      width: newW * 0.85,
                    ),
                  )
                ],
              ),
              if (!isCurrent)
                Positioned(
                  left: newW * 0.03,
                  top: newW * 0.03,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentMark.toString(),
                        style: TextStyle(
                            color: const Color(0xFF5464D3),
                            fontWeight: FontWeight.bold,
                            fontSize: newW * 0.05),
                      ),
                      Text(
                        "/${totalMark.toString()}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: newW * 0.05),
                      )
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}

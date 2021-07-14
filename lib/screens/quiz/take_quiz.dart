import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teachers_app/components/qeustion.dart';
import 'package:teachers_app/widgets/radio_group.dart';

class TakeQuizScreen extends StatefulWidget {
  @override
  _TakeQuizScreenState createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  List<int?> studentAnswers = List.generate(5, (index) => null);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    //    Color(0xFF9E43DA).withAlpha(150),
                    Color(0xFF398CE0),
                    Color(0xFF4D68D4),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: w > 600 || or == Orientation.landscape
                      ? EdgeInsets.only(top: 8, right: w * 0.05, left: w * 0.05)
                      : const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            print(studentAnswers);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white54,
                            size: w * 0.07,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.check,
                            color: Colors.white54,
                            size: w * 0.07,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: w > 600 || or == Orientation.landscape
                      ? EdgeInsets.only(
                          bottom: 15, right: w * 0.035, left: w * 0.035)
                      : const EdgeInsets.only(bottom: 15, right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عدد الاسئلة 15',
                        style: TextStyle(
                          fontSize: w * 0.045,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        'اسم الامتحان',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: w * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: 5,
                      itemBuilder: (context, index) => QuestionComponent(
                        questionIndex: index,
                        studentAnswers: studentAnswers,
                        title: 'ما هي البتاعة اللي هناك دي يا معلم حنتيرة',
                        image:
                            "https://www.sanfoundry.com/wp-content/uploads/2017/12/engineering-mechanics-basic-questions-answers-q2.png",
                        questionAnswers: [
                          "Horizontuew 1",
                          "Horizontal 2",
                          "Horizontal 3"
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

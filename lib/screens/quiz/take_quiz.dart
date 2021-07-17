import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:teachers_app/components/qeustion.dart';
import 'package:teachers_app/helpers/quiz.dart';
import 'package:teachers_app/models/quiz_models.dart';
import 'package:teachers_app/widgets/dialogs/quiz_buttons_dialogs.dart';
import 'package:teachers_app/widgets/radio_group.dart';

class TakeQuizScreen extends StatefulWidget {
  final List<QuestionModel> questions;
  final String examName;

  const TakeQuizScreen({
    Key? key,
    required this.questions,
    required this.examName,
  }) : super(key: key);
  @override
  _TakeQuizScreenState createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  late List<int?> studentAnswers;
  @override
  void initState() {
    super.initState();
    studentAnswers = List.generate(widget.questions.length, (index) => -1);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return WillPopScope(
      onWillPop: () async {
        quizArrowBackButton(context);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
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
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: w > 600 || or == Orientation.landscape
                          ? EdgeInsets.only(
                              top: 8, right: w * 0.05, left: w * 0.05)
                          : const EdgeInsets.only(top: 8, right: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                quizArrowBackButton(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white54,
                                size: w * 0.07,
                              )),
                          IconButton(
                              onPressed: () {
                                List<int> realAnswers = [];
                                for (var i = 0;
                                    i < studentAnswers.length;
                                    i++) {
                                  if (studentAnswers[i] == -1) {
                                    realAnswers.add(-1);
                                    continue;
                                  }
                                  realAnswers.add(widget.questions[i]
                                          .answers[studentAnswers[i]!]['id']
                                      as int);
                                }
                                print(realAnswers);
                                quizSubmitButton(context);
                              },
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
                          : const EdgeInsets.only(
                              bottom: 15, right: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'عدد الاسئلة ${widget.questions.length}',
                              style: TextStyle(
                                fontSize: w * 0.045,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.examName,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: w * 0.05,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: widget.questions.length,
                        itemBuilder: (context, index) => QuestionComponent(
                          questionIndex: index,
                          studentAnswers: studentAnswers,
                          title: widget.questions[index].title,
                          image: widget.questions[index].image,
                          questionAnswers: QuizHelper.getQuestionAnswers(
                              widget.questions[index].answers),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

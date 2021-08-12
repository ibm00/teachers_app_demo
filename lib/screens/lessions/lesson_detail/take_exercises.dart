import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../../api/quiz_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../helpers/quiz.dart';
import '../../../models/lessons_model.dart';
import '../../../models/quiz_models.dart';
import '../../../providers/loading_provider.dart';
import '../../../providers/user_data_provider.dart';
import '../../../widgets/dialogs/flutter_toast.dart';
import '../../../widgets/dialogs/quiz_buttons_dialogs.dart';
import '../../../widgets/radio_group.dart';

class TakeExerciseScreen extends StatefulWidget {
  final List<LessonQuizQuestionModel> questions;
  final String examName;
  TakeExerciseScreen({
    required this.questions,
    required this.examName,
  });
  @override
  _TakeExerciseScreenState createState() => _TakeExerciseScreenState();
}

class _TakeExerciseScreenState extends State<TakeExerciseScreen> {
  List<int> correctAnswers = [];
  List<int?> studentsAnswers = [];
  @override
  void initState() {
    super.initState();
    studentsAnswers = List.generate(widget.questions.length, (index) => -1);
    for (var i = 0; i < widget.questions.length; i++) {
      for (var k = 0; k < widget.questions[i].answers.length; k++) {
        bool isCorrect = widget.questions[i].answers[k]['correct'] as bool;
        if (isCorrect) {
          correctAnswers.add(k);
        }
      }
    }
    print(correctAnswers);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
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
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white54,
                              size: w * 0.07,
                            )),
                        IconButton(
                            onPressed: () {
                              print(studentsAnswers);
                              int score = 0;
                              for (var i = 0; i < studentsAnswers.length; i++) {
                                if (studentsAnswers[i] == correctAnswers[i]) {
                                  score++;
                                }
                              }
                              print('this is score:$score');
                              showCustomDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  title:
                                      'النتيجة :$score/${studentsAnswers.length}',
                                  okText: ' حسنا',
                                  okFun: () {},
                                  allowDissmiss: true);
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
                        : const EdgeInsets.only(bottom: 15, right: 8, left: 8),
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
                      itemBuilder: (context, index) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  widget.questions[index].text,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          w > 600 || or == Orientation.landscape
                                              ? 30
                                              : 19),
                                ),
                                const SizedBox(height: 10),
                                Visibility(
                                  visible:
                                      widget.questions[index].image.isNotEmpty,
                                  child: SizedBox(
                                    width: w * 0.9,
                                    child: Image.network(
                                      widget.questions[index].image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                FlutterRadioGroup(
                                  titles: QuizHelper.getQuestionAnswersStrings(
                                      widget.questions[index].answers),
                                  labelVisible: false,
                                  activeColor: Colors.blue,
                                  titleStyle: TextStyle(
                                      fontSize:
                                          w > 600 || or == Orientation.landscape
                                              ? 25
                                              : 16),
                                  defaultSelected: studentsAnswers[index],
                                  onChanged: (int? j) {
                                    setState(() {
                                      studentsAnswers[index] = j;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../api/quiz_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/loading_provider.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/dialogs/flutter_toast.dart';
import '../../widgets/radio_group.dart';
import '../../components/qeustion.dart';
import '../../helpers/quiz.dart';
import '../../models/quiz_models.dart';
import '../../widgets/dialogs/quiz_buttons_dialogs.dart';

class PreviewQuiz extends StatefulWidget {
  final List<QuestionModel> questions;
  final String examName;
  final List answers;
  final Map<int, int> matcherMap;
  PreviewQuiz(
      {required this.questions,
      required this.examName,
      required this.answers,
      required this.matcherMap});
  @override
  _PreviewQuizState createState() => _PreviewQuizState();
}

class _PreviewQuizState extends State<PreviewQuiz> {
  @override
  void initState() {
    super.initState();
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
                        Text(
                          'عدد الاسئلة ${widget.questions.length}',
                          style: TextStyle(
                            fontSize: w * 0.045,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: w > 600 || or == Orientation.landscape
                        ? EdgeInsets.only(
                            bottom: 15, right: w * 0.035, left: w * 0.035)
                        : const EdgeInsets.only(bottom: 15, right: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.examName,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: w * 0.05,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                        int? solvedQuestionIndex;
                        List<int> solvedQuestionsIndeces =
                            widget.matcherMap.keys.toList();
                        solvedQuestionsIndeces.forEach((element) {
                          if (index == element) {
                            solvedQuestionIndex = element;
                          }
                        });
                        if (solvedQuestionIndex != null) {
                          int? selectedId =
                              widget.matcherMap[solvedQuestionIndex];
                          solvedQuestionIndex =
                              QuizHelper.getQuestionsAnswersIds(
                                      widget.questions[index].answers)
                                  .indexOf(selectedId!);
                        }
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
                                  widget.questions[index].title,
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
                                  defaultSelected: solvedQuestionIndex,
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

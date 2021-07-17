import 'package:flutter/material.dart';

import 'package:teachers_app/widgets/radio_group.dart';

class QuestionComponent extends StatefulWidget {
  final List<String> questionAnswers;
  List<int?> studentAnswers;
  final String image;
  final String title;
  final int questionIndex;
  QuestionComponent({
    required this.questionAnswers,
    required this.image,
    required this.title,
    required this.questionIndex,
    required this.studentAnswers,
  });

  @override
  _QuestionComponentState createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: w > 600 || or == Orientation.landscape ? 30 : 19),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: widget.image.isNotEmpty,
              child: SizedBox(
                width: w * 0.9,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            FlutterRadioGroup(
              titles: widget.questionAnswers,
              labelVisible: false,
              activeColor: Colors.blue,
              titleStyle: TextStyle(
                  fontSize: w > 600 || or == Orientation.landscape ? 25 : 16),
              defaultSelected: widget.studentAnswers[widget.questionIndex],
              onChanged: (index) {
                setState(() {
                  widget.studentAnswers[widget.questionIndex] = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

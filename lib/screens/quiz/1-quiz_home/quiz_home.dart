import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/providers/quiz_provider.dart';

import '../../../providers/indices_provider.dart';
import 'current_quizes.dart';
import 'old_quizes.dart';

class QuizHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      //  backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FA),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الامتحانات',
          style: TextStyle(
            fontSize: w * 0.06,
            color: const Color(0xFF5464D3),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF5464D3),
              size: w * 0.07,
            )),
        actions: [
          IconButton(
              onPressed: () {
                context.refresh(currentQuizProvider);
                context.refresh(oldQuizProvider);
              },
              icon: Icon(
                Icons.refresh,
                color: const Color(0xFF5464D3),
                size: w * 0.07,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10),
              child: Consumer(
                builder: (context, watch, child) {
                  final isCurrent = watch(quizHomeScreenIndex).state;
                  return SizedBox(
                    width: w * 0.8,
                    height: or == Orientation.landscape ? h * 0.2 : h * 0.08,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double rowW = constraints.maxWidth;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read(quizHomeScreenIndex).state = false;
                              },
                              child: Material(
                                elevation: !isCurrent ? 5 : 0,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                child: SizedBox(
                                  width: (rowW / 2) - 3,
                                  child: Text(
                                    'السابقة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: w * 0.05,
                                        color: !isCurrent
                                            ? const Color(0xFF5464D3)
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read(quizHomeScreenIndex).state = true;
                              },
                              child: Material(
                                elevation: isCurrent ? 5 : 0,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: SizedBox(
                                  width: (rowW / 2) - 3,
                                  child: Text(
                                    'الحالية',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: w * 0.05,
                                        color: isCurrent
                                            ? const Color(0xFF5464D3)
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(
              builder: (context, watch, child) {
                final isCurrent = watch(quizHomeScreenIndex).state;
                return isCurrent ? CurrentQuizesScreen() : OldQuizesScreen();
              },
            )
          ],
        ),
      ),
    );
  }
}

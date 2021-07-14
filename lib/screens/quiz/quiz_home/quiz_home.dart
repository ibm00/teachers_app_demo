import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/providers/indices_provider.dart';

class QuizHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      //  backgroundColor: const Color(0xFFF4F6FA),
      backgroundColor: Colors.amber,
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
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF5464D3),
              size: w * 0.07,
            )),
      ),
      body: Column(
        children: [
          Center(
            child: Consumer(
              builder: (context, watch, child) {
                final isCurrent = watch(quizHomeScreenIndex).state;
                return SizedBox(
                  width: w * 0.8,
                  height: h * 0.08,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double rowW = constraints.maxWidth;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
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
                          Material(
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
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: w * 0.9,
            height: h * 0.27,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double newH = constraints.maxHeight;
                double newW = constraints.maxWidth;
                return Column(
                  children: [],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

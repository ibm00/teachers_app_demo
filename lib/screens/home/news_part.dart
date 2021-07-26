import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:teachers_app/providers/news_provider.dart';

import 'all_news_screen.dart';

class NewsPartScreen extends StatefulWidget {
  @override
  _NewsPartScreenState createState() => _NewsPartScreenState();
}

class _NewsPartScreenState extends State<NewsPartScreen> {
  late PageController controller;

  GlobalKey<PageContainerState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        color: const Color(0xFF398CE0),
        height: w > 600 || or == Orientation.landscape
            ? w * 0.45
            : (h < 735 ? h * 0.23 + 30 : h * 0.25),
        width: w * 0.85,
        child: LayoutBuilder(builder: (_, constrains) {
          double _maxH = constrains.maxHeight;
          double _maxW = constrains.maxWidth;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllNewsScreen(),
                  ));
            },
            child: SizedBox(
              height: _maxH,
              width: _maxW,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/last_news_word.svg',
                    width: _maxW * 0.85,
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final futureData = watch(newsFutureProvider);
                      return futureData.when(
                        data: (value) {
                          return Expanded(
                            child: PageIndicatorContainer(
                              length: value.length,
                              indicatorSpace: 10.0,
                              key: key,
                              child: PageView(
                                controller: controller,
                                reverse: true,
                                children: value
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Center(
                                          child: Text(
                                            e.body,
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontSize: _maxW * 0.06,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        loading: () => Padding(
                          padding: EdgeInsets.only(top: _maxH * 0.3),
                          child: Text(
                            'جاري تحميل الاخبار',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: _maxW * 0.06, color: Colors.white),
                          ),
                        ),
                        error: (error, stackTrace) {
                          print('this is get news in home screen error $error');
                          return Padding(
                            padding: EdgeInsets.only(top: _maxH * 0.3),
                            child: Text(
                              'حدث مشكلة الرجاء المحاولة لاحقا',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: _maxW * 0.06, color: Colors.white),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

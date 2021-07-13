import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_indicator/page_indicator.dart';

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
            : (h < 735 ? h * 0.23 + 30 : h * 0.23),
        width: w * 0.85,
        child: LayoutBuilder(builder: (_, constrains) {
          double _maxH = constrains.maxHeight;
          double _maxW = constrains.maxWidth;

          return SizedBox(
            height: _maxH,
            width: _maxW,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/last_news_word.svg',
                  width: _maxW * 0.85,
                ),
                Expanded(
                  child: PageIndicatorContainer(
                    key: key,
                    child: PageView(
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              'ما هو مهمل. هو بريد إلكتروني تنتهي صلاحيته بعد مدة معينة من إنشائه ويمكنك استخدامه خلال هذه المدة · استخدامات. يمكنك',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: _maxW * 0.06, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: _maxH * 0.06, right: _maxW * 0.04),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'السبت , 9 مايو , 2021 الساعه 9:30 مساءا',
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: _maxW * 0.035,
                                      color: Colors.white54),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text('2'),
                        Text('3'),
                        Text('4'),
                      ],
                      controller: controller,
                      reverse: true,
                    ),
                    length: 4,
                    indicatorSpace: 10.0,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

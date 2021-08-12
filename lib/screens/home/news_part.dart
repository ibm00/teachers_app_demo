import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../providers/news_provider.dart';

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

  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    context.refresh(newsFutureProvider);
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    context.refresh(newsFutureProvider);
    setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final Orientation or = MediaQuery.of(context).orientation;
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
                ),
              );
            },
            child: SizedBox(
              height: _maxH,
              width: _maxW,
              child: SmartRefresher(
                header: const WaterDropHeader(),
                controller: _refreshController,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
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
                                        (e) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  e.body,
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: _maxW * 0.06,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Text(''),
                                          ],
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
                            print(
                                'this is get news in home screen error $error');
                            return Padding(
                              padding: EdgeInsets.only(top: _maxH * 0.3),
                              child: Text(
                                'حدث مشكلة الرجاء المحاولة لاحقا',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: _maxW * 0.06,
                                    color: Colors.white),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

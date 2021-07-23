import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/providers/news_provider.dart';

import '../../providers/actions_provider.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/loading.dart';

class AllNewsScreen extends StatefulWidget {
  @override
  _AllNewsScreenState createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  late ScrollController _scrollController;
  int page = 1;
  @override
  void initState() {
    super.initState();
    final newsPro = context.read(newsProvider);
    newsPro.getDataByPage(context.read(userDataProvider).token, page);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels.floor() >
          (_scrollController.position.maxScrollExtent.floor() - 60)) {
        if (newsPro.isThereIsNextPage) {
          page++;
          newsPro.getDataByPage(context.read(userDataProvider).token, page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D68D4),
        centerTitle: true,
        title: Text('الاخبار'),
      ),
      body: SafeArea(child: Consumer(
        builder: (context, watch, child) {
          final data = watch(newsProvider);
          print(data.news.length.toString() + '**');
          return data.news.isEmpty
              ? Center(child: LoadingWidgets.getNormalLoading())
              : Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 25,
                    ),
                    controller: _scrollController,
                    itemCount: data.news.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: w * 0.07),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      //      height: h * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFEFF3F6),
                      ),
                      child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              data.news[index].body,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: w * 0.05),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data.news[index].title,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: w * 0.03),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      )),
    );
  }
}

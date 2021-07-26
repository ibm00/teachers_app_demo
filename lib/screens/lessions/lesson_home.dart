import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teachers_app/models/lessons_model.dart';
import 'package:teachers_app/providers/lesson_provider.dart';
import 'package:teachers_app/screens/lessions/lesson_detail/lesson_detail.dart';
import 'package:teachers_app/widgets/loading.dart';
import 'lesson_detail/lesson_detail.dart';
import '../../constants.dart';

class LessionsAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    double h = size.height;
    double w = size.width;
    p.lineTo(0, h * 0.75);
    p.quadraticBezierTo(w * 0.5, h, w, 0);
    p.lineTo(w, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class LessionsHomeScreen extends ConsumerWidget {
  // const LessionsHomeScreen({Key? key}) : super(key: key);
  // final GlobalKey<ExpansionTileCardState> _key = new GlobalKey();

  @override
  Widget build(BuildContext context, watch) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    final futureChapter = watch(chaptersProvider);
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCustomAppBar(h, or),
              futureChapter.when(
                data: (value) {
                  print(value);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: value!.length,
                      itemBuilder: (context, index1) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: ExpansionTileCard(
                            contentPadding: EdgeInsets.all(w * 0.05),
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            expandedTextColor: kPrimaryColor,
                            leading: SvgPicture.asset(
                              'assets/images/section_icon.svg',
                              width: w * 0.15,
                              height: or == Orientation.portrait
                                  ? h * 0.07
                                  : h * 0.2,
                            ),
                            title: Text(
                              value[index1]['title'].toString(),
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: w * 0.05),
                            ),
                            children: <Widget>[
                              const Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              SizedBox(
                                height:
                                    or == Orientation.portrait ? h * 0.4 : h,
                                child: ListView.builder(
                                  itemCount:
                                      (value[index1]['modules'] as List).length,
                                  itemBuilder: (context, index2) {
                                    List l = value[index1]['modules'] as List;
                                    Map m = l[index2] as Map;
                                    LessonModel model = LessonModel.fromMap(m);
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 0.1),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LessonDetailScreen(
                                                        lessonModel: model,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // SvgPicture.asset(
                                            //   'assets/images/lesson_icon.svg',
                                            //   width: w * 0.15,
                                            //   height: w * 0.15,
                                            //   fit: BoxFit.cover,
                                            // ),
                                            Text(
                                              '${index2 + 1}-  ',
                                              style:
                                                  TextStyle(fontSize: w * 0.06),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.title,
                                                style: TextStyle(
                                                    fontSize: w * 0.07),
                                              ),
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
                        );
                      },
                    ),
                  );
                },
                loading: () => SizedBox(
                    height: h / 2,
                    child: Center(child: LoadingWidgets.getNormalLoading())),
                error: (error, stackTrace) {
                  print('this is future chapters error : $error');
                  return SizedBox(
                      height: h / 2,
                      child: Center(child: LoadingWidgets.getNormalLoading()));
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildCustomAppBar(double h, Orientation or) {
    return ClipPath(
      clipper: LessionsAppBarClipper(),
      child: Container(
          width: double.infinity,
          height: or == Orientation.portrait ? h * 0.15 : h * 0.35,
          color: kPrimaryColor,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double newW = constraints.maxWidth;
              double newH = constraints.maxHeight;
              return Padding(
                padding: EdgeInsets.only(left: newW * 0.03, top: newH * 0.1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: newW * 0.08,
                        )),
                    SizedBox(
                      width: newW * 0.05,
                    ),
                    Text(
                      'الدروس',
                      style: TextStyle(
                        fontSize: newW * 0.065,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

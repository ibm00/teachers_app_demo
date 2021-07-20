import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
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

class LessionsHomeScreen extends StatelessWidget {
  // const LessionsHomeScreen({Key? key}) : super(key: key);
  // final GlobalKey<ExpansionTileCardState> _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCustomAppBar(h, or),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
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
                        height: or == Orientation.portrait ? h * 0.07 : h * 0.2,
                      ),
                      title: Text(
                        'اسم القسم',
                        style:
                            TextStyle(color: kPrimaryColor, fontSize: w * 0.05),
                      ),
                      children: <Widget>[
                        const Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: or == Orientation.portrait ? h * 0.4 : h,
                          child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) => Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/lesson_icon.svg',
                                    width: w * 0.15,
                                    height: w * 0.15,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'kwehrw',
                                      style: TextStyle(fontSize: w * 0.07),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
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

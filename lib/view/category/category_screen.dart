import 'package:flutter/material.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CategoryMovie extends StatefulWidget {
  const CategoryMovie({super.key});

  @override
  State<CategoryMovie> createState() => _CategoryMovieState();
}

class _CategoryMovieState extends State<CategoryMovie> {
  late SizingInformation sizeInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            title: StringConst.homeTitle, bgColor: ColorConst.whiteBgColor),
        body: _createUi());
  }

  Widget _createUi() {
    return ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo = sizeInf;
      return Scrollbar(
          thumbVisibility:
              sizeInfo.deviceScreenType == DeviceScreenType.desktop,
          radius: const Radius.circular(5),
          thickness:
              sizeInfo.deviceScreenType == DeviceScreenType.desktop ? 20 : 0,
          child: SingleChildScrollView(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: imgList.length,
                  itemBuilder: (context, pos) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        height: 148,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Stack(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      imgList[pos],
                                    ),
                                  ),
                                ),
                                height: 350.0,
                              ),
                              Container(
                                height: 350.0,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.black26,
                                          Colors.black26,
                                        ],
                                        stops: [
                                          0.0,
                                          1.0
                                        ])),
                              ),
                              const Center(
                                  child: Text(
                                "Kampanya",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                            ])));
                  })));
    });
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1513884923967-4b182ef167ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1487412912498-0447578fcca8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1526178613552-2b45c6c302f0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1472417583565-62e7bdeda490?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
];

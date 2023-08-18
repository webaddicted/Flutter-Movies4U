import 'package:flutter/material.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/intro/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 40),
        getTxtAppColor(
            msg: slideList[index].title,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
          child: getTxtBlackColor(
              msg: slideList[index].description,
              fontSize: 18,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

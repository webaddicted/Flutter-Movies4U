import 'package:Moviesfree4U/constant/string_const.dart';
import 'package:Moviesfree4U/model/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:Moviesfree4U/constant/assets_const.dart';
import 'package:Moviesfree4U/constant/color_const.dart';
import 'package:Moviesfree4U/view/intro/intro_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // SPManager.getThemeDark();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SPManager.getThemeDark()
    // return getView(null);
    return ScopedModel(
      model: ThemeModel(),
      child: getView(),
    );
  }

  Widget getView() {
    return ScopedModelDescendant<ThemeModel>(
        builder: (context, _, model) => MaterialApp(
              title: StringConst.APP_NAME,
              debugShowCheckedModeBanner: false,
              // darkTheme: ThemeData.light(),
              darkTheme: model.getTheme ? ThemeData.dark():ThemeData.light(),
              theme: ThemeData(
                fontFamily: AssetsConst.ZILLASLAB_FONT,
                accentColor: ColorConst.APP_COLOR,
                accentColorBrightness: Brightness.light,
                primarySwatch: ColorConst.APP_COLOR,
              ),
              home: IntroScreen(),
            ));
  }
}

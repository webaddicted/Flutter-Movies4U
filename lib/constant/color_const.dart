import 'package:flutter/material.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';

class ColorConst {
  // "63FF90"
  static const  appColor = Colors.green;
  static Color greyColor = Colors.grey;
  static Color redColor = Colors.red;
  static Color greenColor = Colors.green;
  static Color blackOrigColor = Colors.black;
  static Color whiteOrigColor = Colors.white;

  static Color blackColor = isDarkMode() ? Colors.white : Colors.black;
  static Color whiteColor = isDarkMode() ? Colors.black : Colors.white;
  static Color blackBgColor = Colors.black54;
  static Color whiteBgColor = isDarkMode() ? Colors.grey.shade800 : Colors.white;

  static Color grey800 = Colors.grey.shade800;

//  static Color BLACK_COLOR = colorFromHex("#000000");
//  static Color WHITE_COLOR = colorFromHex("#FFFFFF");
  static var fcmAppColor = colorFromHex("#fbae44"); //fbae00//f98e14
  static Color fbColor = colorFromHex("#2951a6");
  static Color googleColor = colorFromHex("#f14336");
  static  Color twitterColor = colorFromHex("#00acee");
  static Color slider1Color = colorFromHex("#f64c73");
  static Color slider2Color = colorFromHex("#20d2bb");
  static Color slider3Color = colorFromHex("#3395ff");
  static Color slider4Color = colorFromHex("#c873f4");
  static Color greyShade = Colors.grey.shade400;
  static Color splashColor = Colors.redAccent;
  static Color shimmerColor = Colors.grey.shade300;
  static Color circleFade1 = colorFromHex('#9BCCFFFF');
  static Color circleFade2 = colorFromHex('#ACCCE6FF');
  static Color circleFade3 = colorFromHex('#93FFFFCC');
  static Color blackFade = colorFromHex('#5E000000');

// static var APP_COLORss;
}

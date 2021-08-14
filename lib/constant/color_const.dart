import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';

class ColorConst {
  // "63FF90"
  static const  APP_COLOR = Colors.green;
  static Color GREY_COLOR = Colors.grey;
  static Color RED_COLOR = Colors.red;
  static Color GREEN_COLOR = Colors.green;
  static Color BLACK_ORIG_COLOR = Colors.black;
  static Color WHITE_ORIG_COLOR = Colors.white;

  static Color BLACK_COLOR = isDarkMode() ? Colors.white : Colors.black;
  static Color WHITE_COLOR = isDarkMode() ? Colors.black : Colors.white;
  static Color BLACK_BG_COLOR = Colors.black54;
  static Color WHITE_BG_COLOR =
      isDarkMode() ? Colors.grey.shade800 : Colors.white;

  static Color GREY_800 = Colors.grey.shade800;

//  static Color BLACK_COLOR = colorFromHex("#000000");
//  static Color WHITE_COLOR = colorFromHex("#FFFFFF");
  static var FCM_APP_COLOR = colorFromHex("#fbae44"); //fbae00//f98e14
  static Color FB_COLOR = colorFromHex("#2951a6");
  static Color GOOGLE_COLOR = colorFromHex("#f14336");
  static  Color TWITTER_COLOR = colorFromHex("#00acee");
  static Color SLIDER1_COLOR = colorFromHex("#f64c73");
  static Color SLIDER2_COLOR = colorFromHex("#20d2bb");
  static Color SLIDER3_COLOR = colorFromHex("#3395ff");
  static Color SLIDER4_COLOR = colorFromHex("#c873f4");
  static Color GREY_SHADE = Colors.grey.shade400;
  static Color SPLASH_COLOR = Colors.redAccent;
  static Color SHIMMER_COLOR = Colors.grey.shade300;
  static Color CIRCLE_FADE1 = colorFromHex('#9BCCFFFF');
  static Color CIRCLE_FADE2 = colorFromHex('#ACCCE6FF');
  static Color CIRCLE_FADE3 = colorFromHex('#93FFFFCC');
  static Color BLACK_FADE = colorFromHex('#5E000000');

// static var APP_COLORss;
}

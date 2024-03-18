import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/SlideRoute.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/global_utility.dart';

//  {START PAGE NAVIGATION}
// void navigationPush(BuildContext context, StatefulWidget route) {
//   Navigator.push(context, MaterialPageRoute(
//     builder: (context) {
//       return route;
//     },
//   ));
// }
// void navigationPop(BuildContext context, StatefulWidget route) {
//   Navigator.pop(context, MaterialPageRoute(builder: (context) {
//     return route;
//   }));
// }
void navigationPush(BuildContext context, StatefulWidget route) {
  Navigator.push(context, RouteTransition(widget: route));
}

void navigationPushReplacement(BuildContext context, Widget route) {
  Navigator.pushReplacement(context, RouteTransition(widget: route));
}
void navigationPushReplacementsss(BuildContext context,String name, Widget route) {
  Navigator.pushReplacementNamed(context,name);
}

void navigationPop(BuildContext context, StatefulWidget route) {
  Navigator.pop(context, RouteTransition(widget: route));
}

void navigationStateLessPush(BuildContext context, StatelessWidget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void navigationStateLessPop(BuildContext context, StatelessWidget route) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void delay(BuildContext context, int duration, StatefulWidget route) {
  Future.delayed(const Duration(seconds: 3), () {
    navigationPush(context, route);
  });
}

//  {END PAGE NAVIGATION}


Widget apiHandler<T>(
    {required ApiResponse<T> response, Widget? loading, Widget? error}) {
  if (response.status == null) {
    return Container();
  } else {
    switch (response.status) {
      case ApiStatus.loading:
        return loading ?? const Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(ColorConst.appColor),
          ),
        );
      case ApiStatus.error:
        return Center(
          child: getTxtColor(
              msg: response.apiError!.errorMessage.toString(),
              txtColor: ColorConst.redColor),
        );
        // return error != null ? error : showError(response.apierror.errorMessage);
      default:
        {
          return Container(
            color: Colors.amber,
            child: getTxtAppColor(msg: StringConst.somethingWentWrong),
          );
        }
    }
  }
}



// Widget apiHandler<T>({ApiResponse<T> response, Widget loading, Widget error}) {
//   switch (response.status) {
//     case ApiStatus.LOADING:
//       return loading != null ? loading : Loading();
//       break;
//     case ApiStatus.ERROR:
//       return error != null
//           ? error
//           : Error(
//               errorMessage: response.apierror.errorMessage,
//               onRetryPressed: () {
//                 //call api
//               },
//             );
//       break;
//     default:
//       {
//         return Container(
//           color: ColorConst.GREY_SHADE,
//         );
//       }
//   }
// }
//
// class Error extends StatelessWidget {
//   final String errorMessage;
//
//   final Function onRetryPressed;
//
//   const Error({Key key, this.errorMessage, this.onRetryPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             errorMessage,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.lightGreen,
//               fontSize: 18,
//             ),
//           ),
//           SizedBox(height: 8),
//           RaisedButton(
//             color: Colors.lightGreen,
//             child: Text('Retry', style: TextStyle(color: Colors.white)),
//             onPressed: onRetryPressed,
//           )
//         ],
//       ),
//     );
//   }
// }

// class Loading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "loadingMessage",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.lightGreen,
//               fontSize: 24,
//             ),
//           ),
//           SizedBox(height: 24),
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
//           ),
//         ],
//       ),
//     );
//   }
// }


AppBar getAppBarWithBackBtn(
    {String title = '',
      Color bgColor = ColorConst.appColor,
      double fontSize = 15,
      String titleTag = '',
      Widget? icon,
      List<Widget>? actions}) {
  return AppBar(
    backgroundColor: bgColor,
    leading: icon,
    actions: actions,
    centerTitle: true,
    title: Hero(
        tag: titleTag,
        child: getTxtColor(
            msg: title,
            txtColor: ColorConst.blackColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold)),
  );
}

//  {START TEXT VIEW}
Text getTxt(
    {required String msg,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign textAlign = TextAlign.start}) {
  return Text(msg,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(fontWeight: fontWeight));
}

Text getTxtAppColor(
    {required String msg,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    maxLines: maxLines,
    textAlign: textAlign,
    style: _getFontStyle(
        txtColor: ColorConst.appColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtWhiteColor(
    {required String msg,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    maxLines: maxLines,
    textAlign: textAlign,
    style: _getFontStyle(
        txtColor: ColorConst.whiteColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtBlackColor(
    {required String msg,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    style: _getFontStyle(
        txtColor: ColorConst.blackColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtGreyColor(
    {required String msg,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    style: _getFontStyle(
        txtColor: ColorConst.greyColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtColor(
    {required String msg,
      required Color txtColor,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    style: _getFontStyle(
        txtColor: txtColor, fontSize: fontSize, fontWeight: fontWeight),
  );
}

TextStyle _getFontStyle(
    {required Color txtColor,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      String fontFamily = AssetsConst.zillaslabFont,
      TextDecoration txtDecoration = TextDecoration.none}) {
  return TextStyle(
      color: txtColor,
      fontSize: fontSize,
      decoration: txtDecoration,
      fontFamily: fontFamily,
      fontWeight: fontWeight);
}

//  {END TEXT VIEW}

// ClipRRect loadLocalCircleImg(String imagePath, double radius) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: new FadeInImage.assetNetwork(
//         height: radius,
//         width: radius,
//         fit: BoxFit.fill,
//         placeholder: imagePath,
//         image: 'imgUrl'),
//   );
// }
//
// FadeInImage loadImg(String url, int placeHolderPos) {
//   return new FadeInImage.assetNetwork(
//       fit: BoxFit.fill,
//       placeholder: _getPlaceHolder(placeHolderPos),
//       image: url);
// }
//
// ClipRRect loadCircleImg(String imgUrl, int placeHolderPos, double radius) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: new FadeInImage.assetNetwork(
//         height: radius,
//         width: radius,
//         fit: BoxFit.fill,
//         placeholder: _getPlaceHolder(placeHolderPos),
//         image: imgUrl),
//   );
// }

String _getPlaceHolder(int placeHolderPos) {
  switch (placeHolderPos) {
    case 0:
      return AssetsConst.logoImg;
    default:
      return AssetsConst.logoImg;
  }
}

ClipRRect loadCircleCacheImg(String url, double radius) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: getCacheImage(url: url, height: radius, width: radius));
}

Widget getCacheImage({String url="", double height=double.infinity, double width=double.infinity}) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    width: width,
    height: height,
    imageUrl: url,
    placeholder: (context, url) => Container(
      width: width,
      height: height,
      color: Colors.grey[400],
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Divider getDivider() {
  return Divider(
    color: ColorConst.greyColor,
    height: 1,
  );
}

void showSnackBar(BuildContext context, String message) async {
  try {
    var snackbar = SnackBar(
      content: getTxtWhiteColor(msg: message),
      backgroundColor: ColorConst.greenColor,
      duration: const Duration(seconds: 3),
//    action: SnackBarAction(
//        label: "Undo",
//        onPressed: () {
//          logDubug(message + " undo");
//        }),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  } catch (e) {
    printLog(tag: "Widget Helpr",status: ApiStatus.error,msg:'object $e');
  }
}

bool isDarkMode() {
  // ThemeModel.isDarkTheme;
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;
  // print("IS Dark Mode system : $isDarkMode \n app : ${ThemeModel.dark}");
  // ScopedModel.of<ThemeModel>(context).getTheme;
  return isDarkMode; //appDakMode;
}

// Color getColor(Color color) {
//   if (color == ColorConst.WHITE_COLOR)
//     return isDarkMode() ? ColorConst.BLACK_COLOR : ColorConst.WHITE_COLOR;
//   else if (color == ColorConst.BLACK_COLOR)
//     return isDarkMode() ? ColorConst.WHITE_COLOR : ColorConst.BLACK_COLOR;
//   else if (color == ColorConst.WHITE_BG_COLOR)
//     return isDarkMode() ? ColorConst.BLACK_BG_COLOR : ColorConst.WHITE_BG_COLOR;
//   else
//     return color;
// }

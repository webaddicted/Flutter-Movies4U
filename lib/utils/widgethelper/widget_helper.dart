import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/SlideRoute.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/view/home/home_screen.dart';

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
  if (response.status == null)
    return Container();
  else {
    switch (response.status) {
      case ApiStatus.LOADING:
        return loading != null
            ? loading
            : Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(ColorConst.APP_COLOR),
          ),
        );
        break;
      case ApiStatus.ERROR:
        return Center(
          child: getTxtColor(
              msg: response.apiError!.errorMessage.toString(),
              txtColor: ColorConst.RED_COLOR),
        );
        // return error != null ? error : showError(response.apierror.errorMessage);
        break;
      default:
        {
          return Container(
            color: Colors.amber,
            child: getTxtAppColor(msg: StringConst.SOMETHING_WENT_WRONG),
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
      Color bgColor = ColorConst.APP_COLOR,
      double fontSize = 15,
      String titleTag = '',
      Widget? icon,
      List<Widget>? actions}) {
  return AppBar(
    backgroundColor: bgColor == null ? ColorConst.APP_COLOR : bgColor,
    leading: icon,
    actions: actions,
    centerTitle: true,
    title: Hero(
        tag: titleTag,
        child: getTxtColor(
            msg: title,
            txtColor: ColorConst.BLACK_COLOR,
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
        txtColor: ColorConst.APP_COLOR,
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
        txtColor: ColorConst.WHITE_COLOR,
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
        txtColor: ColorConst.BLACK_COLOR,
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
        txtColor: ColorConst.GREY_COLOR,
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
      String fontFamily = AssetsConst.ZILLASLAB_FONT,
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
      return AssetsConst.LOGO_IMG;
    default:
      return AssetsConst.LOGO_IMG;
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
    width: width != null ? width : double.infinity,
    height: height != null ? height : double.infinity,
    imageUrl: url,
    placeholder: (context, url) => Container(
      width: width != null ? width : double.infinity,
      height: height != null ? height : double.infinity,
      color: Colors.grey[400],
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Divider getDivider() {
  return Divider(
    color: ColorConst.GREY_COLOR,
    height: 1,
  );
}

void showSnackBar(BuildContext context, String message) async {
  try {
    var snackbar = SnackBar(
      content: getTxtWhiteColor(msg: message),
      backgroundColor: ColorConst.GREEN_COLOR,
      duration: Duration(seconds: 3),
//    action: SnackBarAction(
//        label: "Undo",
//        onPressed: () {
//          logDubug(message + " undo");
//        }),
    );
    Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
    await Scaffold.of(context).showSnackBar(snackbar);
  } catch (e) {
    print('object ' + e.toString());
  }
}

bool isDarkMode() {
  // ThemeModel.isDarkTheme;
  var brightness = SchedulerBinding.instance?.window.platformBrightness;
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

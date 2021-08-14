import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late BuildContext _ctx;

  @override
  Widget build(BuildContext context) {
      var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color:ColorConst.BLACK_COLOR,
        ),
        onPressed: () => Navigator.pop(context));
    return Scaffold(
      appBar: getAppBarWithBackBtn(
          title: 'About Us',
          bgColor: ColorConst.WHITE_BG_COLOR,
          titleTag: 'About Us',
          icon: homeIcon),
      body: Builder(builder: (_context) => _createUi(_context)),
    );
  }

  Widget _createUi(BuildContext context) {
    _ctx = context;
    return new Container(
      child: Column(
        children: [
          Expanded(
              child: WebView(
//                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: ApiConstant.WEB_VIEW_URL))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  WebViewController? controller;
  @override
  Widget build(BuildContext context) {
    getController();
      var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color:ColorConst.blackColor,
        ),
        onPressed: () => Navigator.pop(context));
    return Scaffold(
      appBar: getAppBarWithBackBtn(
          title: 'Privacy Policy',
          bgColor: ColorConst.whiteBgColor,
          titleTag: 'Privacy Policy',
          icon: homeIcon),
      body: Builder(builder: (context) => _createUi(context)),
    );
  }

  Widget _createUi(BuildContext context) {
    return Column(
      children: [
        Expanded(child: WebViewWidget(controller: controller!))
      ],
    );
  }
  void getController(){
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(ApiConstant.webViewUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiConstant.privacyPolicy));
  }
}

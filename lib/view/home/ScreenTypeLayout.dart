import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// Author : Deepak Sharma(Webaddicted)
/// Email : deepaksharmatheboss@gmail.com
/// Profile : https://github.com/webaddicted

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout(
      {required this.mobile, required this.tablet, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        if (tablet != null) {
          return tablet;
        }
      }
      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        if (desktop != null) {
          return desktop;
        }
      }
      // Return mobile layout if nothing else is supplied
      return mobile;
    });
  }
}

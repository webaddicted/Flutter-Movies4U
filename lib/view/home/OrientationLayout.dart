import 'package:flutter/cupertino.dart';

/// Author : Deepak Sharma(Webaddicted)
/// Email : deepaksharmatheboss@gmail.com
/// Profile : https://github.com/webaddicted

class OrientationLayout extends StatelessWidget {
  final Widget landscape;
  final Widget portrait;

  OrientationLayout({
    required this.landscape,
    required this.portrait,
  });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape ?? portrait;
    }
    return portrait;
  }
}

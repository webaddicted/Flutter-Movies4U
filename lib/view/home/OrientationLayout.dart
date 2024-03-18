import 'package:flutter/cupertino.dart';

/// Author : Deepak Sharma(Webaddicted)
/// Email : deepaksharmatheboss@gmail.com
/// Profile : https://github.com/webaddicted

class OrientationLayout extends StatelessWidget {
  final Widget landscape;
  final Widget portrait;

  const OrientationLayout({super.key,
    required this.landscape,
    required this.portrait,
  });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape;
    }
    return portrait;
  }
}

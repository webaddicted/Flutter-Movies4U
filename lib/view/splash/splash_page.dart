import 'package:flutter/material.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/utils/sp/sp_manager.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/intro/intro_screen.dart';

class SplashPage extends StatefulWidget {
  static const String route = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  var _visible = false;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var isOnboardingShow = await SPManager.getOnboarding();
    Future.delayed(const Duration(seconds: 4), () {
      // if (isOnboardingShow)
      navigationPushReplacement(context, isOnboardingShow!=null && isOnboardingShow?HomeScreen():IntroScreen());
      // navigationPushReplacementsss(context,HomeScreen.route ,isOnboardingShow!=null && isOnboardingShow?HomeScreen():IntroScreen());

      // else
      //   navigationPush(context, IntroScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 3));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.decelerate);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.WHITE_COLOR,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: animation.value * 250,
                  height: animation.value * 250, //Adapt.px(500),
                  child: Image.asset(AssetsConst.LOGO_IMG)),
              SizedBox(height: 180),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 70),
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(ColorConst.APP_COLOR),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

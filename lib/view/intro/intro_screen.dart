import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constant/color_const.dart';
import 'package:flutter_movie_app/utils/sp/sp_manager.dart';
import 'package:flutter_movie_app/utils/widgethelper/widget_helper.dart';
import 'package:flutter_movie_app/view/home/home_screen.dart';
import 'package:flutter_movie_app/view/intro/slide.dart';
import 'package:flutter_movie_app/view/intro/slide_dots.dart';
import 'package:flutter_movie_app/view/intro/slide_item.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    //used for auto scroll
//    Timer.periodic(Duration(seconds: 5), (Timer timer) {
//      if (_currentPage < 2) {
//        _currentPage++;
//      } else {
//        _currentPage = 0;
//      }
//      _pageController.animateToPage(
//        _currentPage,
//        duration: Duration(milliseconds: 300),
//        curve: Curves.easeIn,
//      );
//    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => _crateUi(context),
    ));
  }

  Widget _crateUi(BuildContext context) {
    Color color = ColorConst.WHITE_COLOR;
    // if (_currentPage == 0)
    //   color = ColorConst.SLIDER1_COLOR;
    // else if (_currentPage == 1)
    //   color = ColorConst.SLIDER2_COLOR;
    // else if (_currentPage == 2)
    //   color = ColorConst.SLIDER3_COLOR;
    // else
    //   color = ColorConst.SLIDER4_COLOR;

    return Stack(
      children: <Widget>[
        Container(
          color: color,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: slideList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 55),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < slideList.length; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: getTxtBlackColor(
                    msg: 'SKIP', fontSize: 16, fontWeight: FontWeight.bold),
                onPressed: () {
                  SPManager.setOnboarding('true');
                  navigationPush(context, HomeScreen());
                },
              ),
              FlatButton(
                child: getTxtBlackColor(
                    msg: _currentPage < 3 ? 'NEXT' : 'DONE',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                onPressed: () {
                  _nextClick();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _nextClick() {
    if (_currentPage < 3) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      SPManager.setOnboarding('true');
      navigationPush(context, HomeScreen());
    }
  }
}

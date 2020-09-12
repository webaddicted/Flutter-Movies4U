import 'package:Moviesfree4U/constant/api_constant.dart';
import 'package:Moviesfree4U/constant/color_const.dart';
import 'package:Moviesfree4U/constant/utils/widgethelper/widget_helper.dart';
import 'package:Moviesfree4U/view/details/movie_list_screen.dart';
import 'package:Moviesfree4U/view/setting/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NavDrawerView extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return _drawerView();
  }

  Widget _drawerView() {
    return new Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            loadCircleCacheImg(
                "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
                140),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "Deepak Sharma",
              style: TextStyle(
                  color: ColorConst.APP_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30)),
                _getDrawerItem("Home"),
                getDivider(),
                _getDrawerItem("Category"),
                getDivider(),
                _getDrawerItem("Tranding Movie"),
                getDivider(),
                _getDrawerItem("Popular Movie"),
                getDivider(),
                _getDrawerItem("Upcoming Movie"),
                getDivider(),
                _getDrawerItem("Setting"),
                getDivider(),
                _getDrawerItem("Contact us"),
                getDivider(),
                _getDrawerItem("About us"),
                getDivider(),
                _getDrawerItem("Exit"),
                getDivider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDrawerItem(String title) {
    return GestureDetector(
      onTap: () {
        _navigateOnNextScreen(title);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                top: 17.0, bottom: 17.0, left: 10.0, right: 3.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateOnNextScreen(String title) {
    Navigator.of(_context).pop();
    switch (title) {
      case "Home":
        // navigationPush(_context, CategoryMovie());
        break;
      case "Category":
        navigationPush(
            _context, MovieListScreen(apiName: ApiConstant.GENRES_LIST));
        break;
      case "Tranding Movie":
        navigationPush(_context,
            MovieListScreen(apiName: ApiConstant.TRENDING_MOVIE_LIST));
        break;
      case "Popular Movie":
        navigationPush(
            _context, MovieListScreen(apiName: ApiConstant.POPULAR_MOVIES));
        break;
      case "Upcoming Movie":
        navigationPush(
            _context, MovieListScreen(apiName: ApiConstant.UPCOMING_MOVIE));
        break;
      case "Setting":
        navigationStateLessPush(_context, SettingsScreen());
        break;
      case "Contact us":
        break;
      case "About us":
        break;
      case "Exit":
        SystemNavigator.pop();
        break;
    }
  }
}

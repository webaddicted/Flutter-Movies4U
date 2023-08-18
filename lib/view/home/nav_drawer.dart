import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/widgethelper/oval-right-clipper.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/listing/movie_list_screen.dart';
import 'package:movies4u/view/other/about_us_screen.dart';
import 'package:movies4u/view/other/feedback_screen.dart';
import 'package:movies4u/view/other/help_screen.dart';
import 'package:movies4u/view/other/invite_friend_screen.dart';
import 'package:movies4u/view/other/privacy_policy.dart';
import 'package:movies4u/view/other/terms_condition.dart';
import 'package:movies4u/view/profile_screen.dart';
import 'package:movies4u/view/setting/settings_screen.dart';
import 'package:share_plus/share_plus.dart';

class NavDrawer extends StatelessWidget {
  late BuildContext _context;

  NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    _context = context;
    return _buildDrawer();
  }

  _buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: ColorConst.whiteBgColor,
              boxShadow: const [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(_context).pop()),
                  ),
                  InkWell(
                    onTap: () => _navigateOnNextScreen('Profile'),
                    child: Container(
                      height: 128,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            ColorConst.greenColor,
                            ColorConst.appColor
                          ])),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(ApiConstant.demoImg),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  getTxtBlackColor(
                    msg: StringConst.deepakSharma,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  getTxtColor(
                      msg: StringConst.webaddicted,
                      fontSize: 16,
                      txtColor: ColorConst.blackColor),
                  const SizedBox(height: 30.0),
                  _buildRow(Icons.home_outlined, "Home"),
                  _buildDivider(),
                  _buildRow(Icons.category_outlined, "Category"),
                  _buildDivider(),
                  _buildRow(Icons.local_movies_outlined, "Tranding Movie",
                      showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.movie_filter_outlined, "Popular Movie",
                      showBadge: false),
                  _buildDivider(),
                  _buildRow(Icons.movie_creation_outlined, "Upcoming Movie", showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.person_pin_circle_outlined, "Profile"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.share, "Share App"),
                  _buildDivider(),
                  _buildRow(Icons.feedback_outlined, "Feedback"),
                  _buildDivider(),
                  _buildRow(Icons.help_outline, "Help us"),
                  _buildDivider(),
                  _buildRow(Icons.supervised_user_circle, "Invite Friend"),
                  _buildDivider(),
                  _buildRow(Icons.privacy_tip_outlined, "Privacy Policy"),
                  _buildDivider(),
                  _buildRow(Icons.quick_contacts_dialer_outlined, "Terms Condition"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "About us"),
                  _buildDivider(),
                  _buildRow(Icons.exit_to_app, "Exit"),
                  _buildDivider(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: ColorConst.greyColor,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () => _navigateOnNextScreen(title),
        child: Row(children: [
          Icon(
            icon,
            color: ColorConst.blackColor,
          ),
          const SizedBox(width: 10.0),
          getTxtColor(
              msg: title,
              txtColor: ColorConst.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
          const Spacer(),
          if (showBadge)
            Material(
              color: ColorConst.appColor,
              elevation: 2.0,
              // shadowColor: ColorConst.APP_COLOR,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                width: 10,
                height: 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConst.appColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // child: Text(
                //   "10+",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
            )
        ]),
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
            _context, MovieListScreen(apiName: ApiConstant.genresList));
        break;
      case "Tranding Movie":
        navigationPush(
            _context, MovieListScreen(apiName: ApiConstant.trendingMovieList));
        break;
      case "Popular Movie":
        navigationPush(
            _context, MovieListScreen(apiName: ApiConstant.popularMovies));
        break;
      case "Upcoming Movie":
        navigationPush(
            _context, MovieListScreen(apiName: ApiConstant.upcomingMovie));
        break;
      case "Profile":
        navigationStateLessPush(_context, ProfileScreen());
        break;
      case "Settings":
        navigationPush(_context, const SettingScreen());
        break;
      case "Share App":
        Share.share(
            '*${StringConst.appName}*\n${StringConst.shareDetails}\n${StringConst.playstoreUrl}');
        break;
      case "Feedback":
        return navigationPush(_context, const FeedbackScreen());
      case "Help us":
        return navigationPush(_context, const HelpScreen());
      case "Invite Friend":
        return navigationPush(_context, const InviteFriend());
      case "Privacy Policy":
        return navigationPush(_context, const PrivacyPolicyScreen());
      case "Terms Condition":
        return navigationPush(_context, const TermsConditionScreen());
      case "About us":
        return navigationPush(_context, const AboutUsScreen());
      case "Exit":
        onWillPop(_context);
        break;
    }
  }
}

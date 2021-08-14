// import 'package:in_app_update/in_app_update.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/home/nav_drawer.dart';
import 'package:movies4u/view/search/search_screen.dart';
import 'package:movies4u/view/widget/carousel_view.dart';
import 'package:movies4u/view/widget/movie_cate.dart';
import 'package:movies4u/view/widget/sifi_movie_row.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:movies4u/view/widget/tranding_person.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel model = MovieModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late BuildContext _context;
  final InAppReview _inAppReview = InAppReview.instance;
  late AppUpdateInfo _updateInfo;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
    model = MovieModel();
    model.fetchNowPlaying();
    // StringConst.TRANDING_PERSON_OF_WEEK
    // model.fetchTrandingPerson();
    callMovieApi(StringConst.TRANDING_PERSON_OF_WEEK, model);
    callMovieApi(ApiConstant.POPULAR_MOVIES, model);
    callMovieApi(ApiConstant.GENRES_LIST, model);
    callMovieApi(ApiConstant.TRENDING_MOVIE_LIST, model);
    callMovieApi(ApiConstant.DISCOVER_MOVIE, model);
    callMovieApi(ApiConstant.UPCOMING_MOVIE, model);
    // model.fetchTrandingPerson();
    callMovieApi(ApiConstant.TOP_RATED, model);
    inAppReview();
  }

  @override
  Widget build(BuildContext context) {
    final InAppReview _inAppReview = InAppReview.instance;
    _context = context;
    var homeIcon = IconButton(
        icon: Icon(
          Icons.sort, //menu,//dehaze,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
          // model.fetchNowPlaying();
          // model.fetchTrandingPerson();
          // callMovieApi(ApiConstant.POPULAR_MOVIES, model);
          // callMovieApi(ApiConstant.GENRES_LIST, model);
          // callMovieApi(ApiConstant.TRENDING_MOVIE_LIST, model);
          // callMovieApi(ApiConstant.DISCOVER_MOVIE, model);
          // callMovieApi(ApiConstant.UPCOMING_MOVIE, model);
          // model.fetchTrandingPerson();
          // callMovieApi(ApiConstant.TOP_RATED, model);
        });
    return WillPopScope(
      onWillPop: () {
        // checkForUpdate();
        return onWillPop(context);
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: getAppBarWithBackBtn(
              title: StringConst.HOME_TITLE,
              bgColor: ColorConst.WHITE_BG_COLOR,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: ColorConst.BLACK_COLOR,
                    ),
                    onPressed: () => navigationPush(context, SearchScreen()))
              ],
              icon: homeIcon),
          drawer: NavDrawer(),
          body: ScopedModel(model: model, child: _createUi())),
    );
  }

  Widget _createUi() {
    return SafeArea(
      child: Container(child: ResponsiveBuilder(builder: (context, sizeInfo) {
        return Scrollbar(
          isAlwaysShown: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
          radius: Radius.circular(5),
          thickness: 20,
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //   ScreenTypeLayout(
                  //   mobile: Container(),
                  //   tablet:  OrientationLayout(
                  //     portrait:  Container(),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  // SizedBox(height:450,child: ShimmerView.movieDetailsTag()),
                  SizedBox(
                      height:
                          sizeInfo.deviceScreenType == DeviceScreenType.desktop
                              ? 380
                              : 180,
                      width: double.infinity,
                      child: CarouselView(sizeInfo)),
                  Center(
                    child: SizedBox(
                        width: sizeInfo.deviceScreenType ==
                                DeviceScreenType.desktop
                            ? 450
                            : 350,
                        height: sizeInfo.deviceScreenType ==
                                DeviceScreenType.desktop
                            ? 80
                            : 70, //Adapt.px(500),
                        child: Image.asset(AssetsConst.DIVIDER_IMG)),
                  ),
                  TrandingMovieRow(
                    apiName: ApiConstant.TRENDING_MOVIE_LIST,
                    sizeInfo: sizeInfo,
                  ),
                  MovieCate(sizeInfo: sizeInfo),
                  TrandingMovieRow(
                      apiName: ApiConstant.POPULAR_MOVIES, sizeInfo: sizeInfo),
                  SifiMovieRow(ApiConstant.UPCOMING_MOVIE, sizeInfo),
                  Center(
                    child: SizedBox(
                        width: sizeInfo.deviceScreenType ==
                                DeviceScreenType.desktop
                            ? 450
                            : 350,
                        height: sizeInfo.deviceScreenType ==
                                DeviceScreenType.desktop
                            ? 80
                            : 70, //Adapt.px(500),
                        child: Image.asset(AssetsConst.DIVIDER_IMG)),
                  ),
                  TrandingMovieRow(
                      apiName: ApiConstant.DISCOVER_MOVIE, sizeInfo: sizeInfo),
                  TrandingPerson(sizeInfo: sizeInfo),
                  TrandingMovieRow(
                      apiName: ApiConstant.TOP_RATED, sizeInfo: sizeInfo),
                ],
              )),
        );
      })),
    );
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      print(info);
      _updateInfo = info;
      if (_updateInfo.updateAvailability == UpdateAvailability.updateAvailable)
        InAppUpdate.performImmediateUpdate()
            .catchError((e) => print(e.toString()));
    }).catchError((e) => print(e.toString()));
  }

  void inAppReview() async {
    try {
      final isAvailable = await _inAppReview.isAvailable();
      if (isAvailable) {
        await _inAppReview.requestReview();
      } else
        print("revieew Not available $isAvailable");
    } catch (e) {
      print("$e");
    }
  }
}

onWillPop(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: getTxtColor(
              msg: "Are you sure you want to exit this app?",
              fontSize: 17,
              txtColor: ColorConst.BLACK_COLOR),
          title: getTxtBlackColor(
              msg: "Warning!", fontSize: 18, fontWeight: FontWeight.bold),
          actions: <Widget>[
            FlatButton(
                child: getTxt(
                  msg: "Yes",
                  // fontSize: 17,
                ),
                onPressed: () => SystemNavigator.pop()),
            FlatButton(
                child: getTxt(
                  msg: "No",
                  // fontSize: 17,
                ),
                onPressed: () => Navigator.pop(context)),
          ],
        );
      });
}

String getTitle(String apiName) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return 'Popular Movie';
    case ApiConstant.GENRES_LIST:
      return 'Category';
    case ApiConstant.TRENDING_MOVIE_LIST:
      return 'Tranding Movie';
    case ApiConstant.DISCOVER_MOVIE:
      return 'Discover Movie';
    case ApiConstant.UPCOMING_MOVIE:
      return 'Upcomming Movie';
    case ApiConstant.TOP_RATED:
      return 'Top Rated Movie';
    case ApiConstant.RECOMMENDATIONS_MOVIE:
      return 'Recommendations';
    case ApiConstant.SIMILAR_MOVIES:
      return 'Similar Movie';
    case ApiConstant.MOVIE_IMAGES:
    case StringConst.IMAGES:
      return StringConst.IMAGES;
    case StringConst.PERSON_MOVIE_CREW:
      return 'Movie As Crew';
    case StringConst.PERSON_MOVIE_CAST:
      return 'Movie As Cast';
    default:
      return apiName;
  }
}

callMovieApi(String apiName, MovieModel model,
    {int movieId = 0, int page = 1}) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return model.fetchPopularMovie(page);
    case ApiConstant.GENRES_LIST:
      return model.fetchMovieCat();
    case ApiConstant.TRENDING_MOVIE_LIST:
      return model.trandingMovie(page);
    case ApiConstant.DISCOVER_MOVIE:
      return model.discoverMovie(page);
    case ApiConstant.UPCOMING_MOVIE:
      return model.upcommingMovie(page);
    case ApiConstant.TOP_RATED:
      return model.topRatedMovie(page);
    case ApiConstant.RECOMMENDATIONS_MOVIE:
      return model.fetchRecommendMovie(movieId, page);
    case ApiConstant.SIMILAR_MOVIES:
      return model.fetchSimilarMovie(movieId, page);
    case ApiConstant.SIMILAR_MOVIES:
      return model.fetchSimilarMovie(movieId, page);
    case StringConst.MOVIE_CAST:
    case StringConst.MOVIE_CREW:
      return model.movieCrewCast(movieId);
    case StringConst.TRANDING_PERSON_OF_WEEK:
      // print("page   $page");
      return model.fetchTrandingPerson(page);
    case StringConst.PERSON_MOVIE_CAST:
    case StringConst.PERSON_MOVIE_CREW:
      return model.fetchPersonMovie(movieId);
    case StringConst.MOVIE_CATEGORY:
      return model.fetchCategoryMovie(movieId, page);
    case StringConst.MOVIES_KEYWORDS:
      return model.fetchKeywordMovieList(movieId, page);
  }
}

getData(String apiName, MovieModel model) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return model.popularMovieRespo;
    case ApiConstant.GENRES_LIST:
      return model.getMovieCat;
    case ApiConstant.TRENDING_MOVIE_LIST:
      return model.getTrandingMovie;
    case ApiConstant.DISCOVER_MOVIE:
      return model.getDiscoverMovie;
    case ApiConstant.UPCOMING_MOVIE:
      return model.getUpcommingMovie;
    case ApiConstant.TOP_RATED:
      return model.getTopRatedMovie;
    case ApiConstant.RECOMMENDATIONS_MOVIE:
      return model.recommendMovieRespo;
    case ApiConstant.SIMILAR_MOVIES:
      return model.similarMovieRespo;
    case StringConst.MOVIE_CAST:
    case StringConst.MOVIE_CREW:
      return model.getMovieCrew;
    case ApiConstant.MOVIE_IMAGES:
      return model.movieImgRespo;
    case StringConst.IMAGES:
      return model.personImageRespo;
    case StringConst.TRANDING_PERSON_OF_WEEK:
      return model.trandingPersonRespo;
    case StringConst.PERSON_MOVIE_CAST:
    case StringConst.PERSON_MOVIE_CREW:
      return model.personMovieRespo;
    case StringConst.MOVIE_CATEGORY:
      return model.catMovieRespo;
    case StringConst.MOVIES_KEYWORDS:
      return model.keywordMovieListRespo;
  }
}

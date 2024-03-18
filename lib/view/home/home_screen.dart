import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/ads/banner_widget.dart';
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

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel model = MovieModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final InAppReview _inAppReview = InAppReview.instance;
  late AppUpdateInfo _updateInfo;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    checkForUpdate();
    model = MovieModel();
    model.fetchNowPlaying();
    // StringConst.TRANDING_PERSON_OF_WEEK
    // model.fetchTrandingPerson();
    callMovieApi(StringConst.trandingPersonOfWeek, model);
    callMovieApi(ApiConstant.popularMovies, model);
    callMovieApi(ApiConstant.genresList, model);
    callMovieApi(ApiConstant.trendingMovieList, model);
    callMovieApi(ApiConstant.discoverMovie, model);
    callMovieApi(ApiConstant.upcomingMovie, model);
    // model.fetchTrandingPerson();
    callMovieApi(ApiConstant.topRated, model);
    inAppReview();
  }

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.sort, //menu,//dehaze,
          color: ColorConst.blackColor,
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
              title: StringConst.homeTitle,
              bgColor: ColorConst.whiteBgColor,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: ColorConst.blackColor,
                    ),
                    onPressed: () =>
                        navigationPush(context, const SearchScreen()))
              ],
              icon: homeIcon),
          drawer: NavDrawer(),
          body: ScopedModel(model: model, child: _createUi())),
    );
  }

  Widget _createUi() {
    return SafeArea(
      child: ResponsiveBuilder(builder: (context, sizeInfo) {
        return Scrollbar(
          controller: scrollController,
          thumbVisibility:
              sizeInfo.deviceScreenType == DeviceScreenType.desktop,
          radius: const Radius.circular(5),
          thickness:
              sizeInfo.deviceScreenType == DeviceScreenType.desktop ? 20 : 0,
          child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //   ScreenTypeLayout(
                  //   mobile: Container(),
                  //   tablet:  OrientationLayout(
                  //     portrait:  Container(),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
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
                        child: Image.asset(AssetsConst.dividerImg)),
                  ),
                  TrandingMovieRow(
                    apiName: ApiConstant.trendingMovieList,
                    sizeInfo: sizeInfo,
                  ),
                  BannerAdsWidget(),
                  MovieCate(sizeInfo: sizeInfo),
                  TrandingMovieRow(
                      apiName: ApiConstant.popularMovies, sizeInfo: sizeInfo),
                  SifiMovieRow(ApiConstant.upcomingMovie, sizeInfo),
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
                        child: Image.asset(AssetsConst.dividerImg)),
                  ),
                  TrandingMovieRow(
                      apiName: ApiConstant.discoverMovie, sizeInfo: sizeInfo),
                  TrandingPerson(sizeInfo: sizeInfo),
                  TrandingMovieRow(
                      apiName: ApiConstant.topRated, sizeInfo: sizeInfo),
                  BannerAdsWidget()
                ],
              )),
        );
      }),
    );
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      printLog(tag: runtimeType.toString(), msg: 'checkForUpdate - $info');
      _updateInfo = info;
      if (_updateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) => printLog(
            tag: runtimeType.toString(),
            status: ApiStatus.error,
            msg: 'checkForUpdate - $e'));
      }
    }).catchError((e) => printLog(
        tag: runtimeType.toString(),
        status: ApiStatus.error,
        msg: 'checkForUpdate - $e'));
  }

  void inAppReview() async {
    try {
      final isAvailable = await _inAppReview.isAvailable();
      if (isAvailable) {
        await _inAppReview.requestReview();
      } else {}
    } catch (e) {
      printLog(tag: "HomePage", status: ApiStatus.error, msg: "$e");
    }
  }

  @override
  void dispose() {
    super.dispose();
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
              txtColor: ColorConst.blackColor),
          title: getTxtBlackColor(
              msg: "Warning!", fontSize: 18, fontWeight: FontWeight.bold),
          actions: <Widget>[
            MaterialButton(
                child: getTxt(
                  msg: "Yes",
                  // fontSize: 17,
                ),
                onPressed: () => SystemNavigator.pop()),
            MaterialButton(
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
    case ApiConstant.popularMovies:
      return 'Popular Movie';
    case ApiConstant.genresList:
      return 'Category';
    case ApiConstant.trendingMovieList:
      return 'Tranding Movie';
    case ApiConstant.discoverMovie:
      return 'Discover Movie';
    case ApiConstant.upcomingMovie:
      return 'Upcomming Movie';
    case ApiConstant.topRated:
      return 'Top Rated Movie';
    case ApiConstant.recommendationsMovie:
      return 'Recommendations';
    case ApiConstant.similarMovies:
      return 'Similar Movie';
    case ApiConstant.movieImages:
    case StringConst.images:
      return StringConst.images;
    case StringConst.personMovieCrew:
      return 'Movie As Crew';
    case StringConst.personMovieCast:
      return 'Movie As Cast';
    default:
      return apiName;
  }
}

callMovieApi(String apiName, MovieModel model,
    {int movieId = 0, int page = 1}) {
  switch (apiName) {
    case ApiConstant.popularMovies:
      return model.fetchPopularMovie(page);
    case ApiConstant.genresList:
      return model.fetchMovieCat();
    case ApiConstant.trendingMovieList:
      return model.trandingMovie(page);
    case ApiConstant.discoverMovie:
      return model.discoverMovie(page);
    case ApiConstant.upcomingMovie:
      return model.upcommingMovie(page);
    case ApiConstant.topRated:
      return model.topRatedMovie(page);
    case ApiConstant.recommendationsMovie:
      return model.fetchRecommendMovie(movieId, page);
    case ApiConstant.similarMovies:
      return model.fetchSimilarMovie(movieId, page);
    case StringConst.movieCast:
    case StringConst.movieCrew:
      return model.movieCrewCast(movieId);
    case StringConst.trandingPersonOfWeek:
      // print("page   $page");
      return model.fetchTrandingPerson(page);
    case StringConst.personMovieCast:
    case StringConst.personMovieCrew:
      return model.fetchPersonMovie(movieId);
    case StringConst.movieCategory:
      return model.fetchCategoryMovie(movieId, page);
    case StringConst.moviesKeywords:
      return model.fetchKeywordMovieList(movieId, page);
  }
}

getData(String apiName, MovieModel model) {
  switch (apiName) {
    case ApiConstant.popularMovies:
      return model.popularMovieRespo;
    case ApiConstant.genresList:
      return model.getMovieCat;
    case ApiConstant.trendingMovieList:
      return model.getTrandingMovie;
    case ApiConstant.discoverMovie:
      return model.getDiscoverMovie;
    case ApiConstant.upcomingMovie:
      return model.getUpcommingMovie;
    case ApiConstant.topRated:
      return model.getTopRatedMovie;
    case ApiConstant.recommendationsMovie:
      return model.recommendMovieRespo;
    case ApiConstant.similarMovies:
      return model.similarMovieRespo;
    case StringConst.movieCast:
    case StringConst.movieCrew:
      return model.getMovieCrew;
    case ApiConstant.movieImages:
      return model.movieImgRespo;
    case StringConst.images:
      return model.personImageRespo;
    case StringConst.trandingPersonOfWeek:
      return model.trandingPersonRespo;
    case StringConst.personMovieCast:
    case StringConst.personMovieCrew:
      return model.personMovieRespo;
    case StringConst.movieCategory:
      return model.catMovieRespo;
    case StringConst.moviesKeywords:
      return model.keywordMovieListRespo;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Moviesfree4U/constant/api_constant.dart';
import 'package:Moviesfree4U/constant/color_const.dart';
import 'package:Moviesfree4U/constant/string_const.dart';
import 'package:Moviesfree4U/model/movie_model.dart';
import 'package:Moviesfree4U/utils/widgethelper/widget_helper.dart';
import 'package:Moviesfree4U/view/widget/carousel_view.dart';
import 'package:Moviesfree4U/view/widget/movie_cate.dart';
import 'package:Moviesfree4U/view/widget/nav_drawer.dart';
import 'package:Moviesfree4U/view/widget/sifi_movie_row.dart';
import 'package:Moviesfree4U/view/widget/tranding_movie_row.dart';
import 'package:Moviesfree4U/view/widget/tranding_person.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel model;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.fetchNowPlaying();
    model.fetchTrandingPerson();
    callMovieApi(ApiConstant.POPULAR_MOVIES, model);
    callMovieApi(ApiConstant.GENRES_LIST, model);
    callMovieApi(ApiConstant.TRENDING_MOVIE_LIST, model);
    callMovieApi(ApiConstant.DISCOVER_MOVIE, model);
    callMovieApi(ApiConstant.UPCOMING_MOVIE, model);
    model.fetchTrandingPerson();
    callMovieApi(ApiConstant.TOP_RATED, model);
  }

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.storage,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
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
    return Scaffold(
        key: _scaffoldKey,
        appBar: getAppBarWithBackBtn(
            ctx: context,
            title: StringConst.HOME_TITLE,
            bgColor: Colors.white,
            icon: homeIcon),
        drawer: Drawer(
          child: NavDrawerView(),
        ),
        body: ScopedModel(model: model, child: _createUi()));
  }

  Widget _createUi() {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              // SizedBox(height:450,child: ShimmerView.movieDetailsTag()),
              CarouselView(),
              TrandingMovieRow(apiName: ApiConstant.TRENDING_MOVIE_LIST),
              MovieCate(),
              TrandingMovieRow(apiName: ApiConstant.POPULAR_MOVIES),
              SifiMovieRow(ApiConstant.UPCOMING_MOVIE),
              TrandingMovieRow(apiName: ApiConstant.DISCOVER_MOVIE),
              TrandingPerson(),
              TrandingMovieRow(apiName: ApiConstant.TOP_RATED),
            ],
          ),
        ),
      ),
    );
  }
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

callMovieApi(String apiName, MovieModel model, {int movieId}) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return model.fetchPopularMovie();
    case ApiConstant.GENRES_LIST:
      return model.fetchMovieCat();
    case ApiConstant.TRENDING_MOVIE_LIST:
      return model.trandingMovie();
    case ApiConstant.DISCOVER_MOVIE:
      return model.discoverMovie();
    case ApiConstant.UPCOMING_MOVIE:
      return model.upcommingMovie();
    case ApiConstant.TOP_RATED:
      return model.topRatedMovie();
    case ApiConstant.RECOMMENDATIONS_MOVIE:
      return model.fetchRecommendMovie(movieId);
    case ApiConstant.SIMILAR_MOVIES:
      return model.fetchSimilarMovie(movieId);
    case ApiConstant.SIMILAR_MOVIES:
      return model.fetchSimilarMovie(movieId);
    case StringConst.MOVIE_CAST:
    case StringConst.MOVIE_CREW:
      return model.movieCrewCast(movieId);
    case StringConst.TRANDING_PERSON_OF_WEEK:
      return model.fetchTrandingPerson();
    case StringConst.PERSON_MOVIE_CAST:
    case StringConst.PERSON_MOVIE_CREW:
      return model.fetchPersonMovie(movieId);
    case StringConst.MOVIE_CATEGORY:
      return model.fetchCategoryMovie(movieId);
    case StringConst.MOVIES_KEYWORDS:
      return model.fetchKeywordMovieList(movieId);
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

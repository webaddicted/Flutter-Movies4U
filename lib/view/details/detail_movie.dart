import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/movie_details_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/widget/movie_cast_crew.dart';
import 'package:movies4u/view/widget/movie_keyword.dart';
import 'package:movies4u/view/widget/movie_tag.dart';
import 'package:movies4u/view/widget/rating_result.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/sifi_movie_row.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:movies4u/view/widget/video_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsMovieScreen extends StatefulWidget {
  final apiName;
  final tag;
  final index;
  final movieId;
  final image, movieName;

  DetailsMovieScreen(this.movieName, this.image, this.apiName, this.index,
      this.movieId, this.tag);

  @override
  _DetailsMovieScreenState createState() =>
      _DetailsMovieScreenState(movieName, image, apiName, index, movieId, tag);
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  late MovieModel model;
  late final double expandedHeight = 350.0;
  late SizingInformation sizeInfo;
  late Size size;

  final image, movieName;
   final apiName;
   final index;
   final movieId;
   final tag;

  _DetailsMovieScreenState(this.movieName, this.image, this.apiName, this.index,
      this.movieId, this.tag);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.movieDetails(movieId);
    model.movieCrewCast(movieId);
    model.fetchRecommendMovie(movieId, 1);
    model.fetchSimilarMovie(movieId, 1);
    model.keywordList(movieId);
    model.movieVideo(movieId);
    model.movieImg(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel(model: model, child: apiresponse(context)));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieDetails;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return _createUi(data: jsonResult.data);
        else
          return apiHandler(
              loading: _createUi(data: null), response: jsonResult);
      },
    );
  }

  Widget _createUi({required MovieDetailsRespo? data}) {
//    print(' obj   :  ' + data.releaseDate);
    size = MediaQuery.of(context).size;
    return Container(child: ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo = sizeInf;
      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _helperImage(data),
          ),
          Scrollbar(
            isAlwaysShown: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
            radius: Radius.circular(5),
            thickness: 20,
            child: CustomScrollView(
              slivers: <Widget>[
                _appBarView(),
                _contentSection(data),
              ],
            ),
          ),
        ],
      );
    }));
  }

  Widget _helperImage(MovieDetailsRespo? data) {
    return Container(
      height: expandedHeight + 50,
      width: size.width,
      child: Hero(
          tag: tag,
          child: Container(
              child: getCacheImage(url: image, height: expandedHeight + 50)
              // ApiConstant.IMAGE_ORIG_POSTER + data.posterPath.toString()),
              )),
    );
  }

  Widget _appBarView() {
    return SliverAppBar(
      leading: Container(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
//            model.movieDetails(movieId);
//            model.movieCrewCast(movieId);
//            model.fetchRecommendMovie(movieId);
//            model.fetchSimilarMovie(movieId);
//            model.movieKeyword(movieId);
            Navigator.pop(context);
          },
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: expandedHeight - 50,
      snap: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _contentSection(MovieDetailsRespo? data) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [getContai(data)],
      ),
    );
  }

  Widget getContai(MovieDetailsRespo? data) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: ColorConst.WHITE_BG_COLOR,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _contentTitle(data),
          SizedBox(
              height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                  ? 30
                  : 5),
          Center(
            child: SizedBox(
                width: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 450
                    : 350,
                height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 80
                    : 70, //Adapt.px(500),
                child: Image.asset(AssetsConst.DIVIDER_IMG)),
          ),
          SifiMovieRow(ApiConstant.MOVIE_IMAGES, sizeInfo),
          MovieCastCrew(
              castCrew: StringConst.MOVIE_CAST,
              sizeInfo: sizeInfo,
              movieId: movieId),
          MovieCastCrew(
              castCrew: StringConst.MOVIE_CREW,
              sizeInfo: sizeInfo,
              movieId: movieId),
          VideoView('Trailer', sizeInfo),
          MovieKeyword('Keyword', sizeInfo),
          SizedBox(
              height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                  ? 30
                  : 5),
          Center(
            child: SizedBox(
                width: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 450
                    : 350,
                height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 80
                    : 70, //Adapt.px(500),
                child: Image.asset(AssetsConst.DIVIDER_IMG)),
          ),
          TrandingMovieRow(
              apiName: ApiConstant.RECOMMENDATIONS_MOVIE,
              sizeInfo: sizeInfo,
              movieId: movieId),
          TrandingMovieRow(
              apiName: ApiConstant.SIMILAR_MOVIES,
              sizeInfo: sizeInfo,
              movieId: movieId),
        ],
      ),
    );
  }

  Widget _contentTitle(MovieDetailsRespo? movie) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: getTxtBlackColor(
                    msg: movieName, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              RatingResult(movie == null ? 0 : movie.voteAverage, 12.0),
              SizedBox(width: 5),
              RatingBar.builder(
                itemSize: 12.0,
                initialRating: movie == null ? 0 : movie.voteAverage! / 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color:
                      getBackgrountRate(movie == null ? 0 : movie.voteAverage!),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
          SizedBox(height: 7),
          MovieTag(items: movie == null ? null : movie.genres, sizes: sizeInfo),
          SizedBox(height: 10),
          _contentAbout(movie),
          SizedBox(height: 10),
          getTxtBlackColor(
              msg: 'Overview', fontSize: 18, fontWeight: FontWeight.bold),
          SizedBox(height: 7),
          if (movie != null)
            getTxtGreyColor(
                msg: movie.overview != null ? movie.overview! : '',
                fontSize: 15,
                fontWeight: FontWeight.w400)
          else
            sizeInfo.deviceScreenType == DeviceScreenType.desktop
                ? Container()
                : ShimmerView.getOverView(context)
        ],
      ),
    );
  }

  Widget _contentAbout(MovieDetailsRespo? _dataMovie) {
    var relDate = "";
    var budget = "";
    var revenue = "";
    if (_dataMovie != null)
      try {
        var inputFormat = DateFormat("yyyy-MM-dd");
        DateTime date1 = inputFormat.parse(_dataMovie.releaseDate!);
        relDate = '${date1.day}/${date1.month}/${date1.year}';
        budget = NumberFormat.simpleCurrency().format(_dataMovie.budget);
        revenue = NumberFormat.simpleCurrency().format(_dataMovie.revenue);
      } catch (exp) {
        print(exp);
      }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _contentDescriptionAbout(
                  'Status', _dataMovie != null ? _dataMovie.status : null),
              _contentDescriptionAbout('Duration',
                  '${_dataMovie != null ? _dataMovie.runtime : null} min'),
              _contentDescriptionAbout(
                  'Release Date', _dataMovie != null ? relDate : null),
              _contentDescriptionAbout(
                  'Budget',
                  '${_dataMovie != null ? _dataMovie.budget == 0 ? ' N/A' : '${budget}' : null}'),
              _contentDescriptionAbout(
                  'Revenue',
                  '${_dataMovie != null ? _dataMovie.revenue == 0 ? ' N/A' : '${revenue}' : null}'),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                width: 80,
                height: 125,
                child: getCacheImage(
                    url: _dataMovie == null
                        ? image
                        : ApiConstant.IMAGE_POSTER +
                            _dataMovie.backdropPath.toString(),
                    height: 125,
                    width: 80)),
          ),
        ],
      ),
    );
  }

  Widget _contentDescriptionAbout(String title, String? value) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            getTxtBlackColor(
                msg: title != null ? title : '',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
            Text(' : '),
            if (value == null)
              Container(
                width: 150,
                height: 10,
                color: Colors.grey[300],
              )
            else
              getTxtAppColor(
                  msg: value != null ? value : '',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

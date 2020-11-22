import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/movie_details_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/widget/movie_tag.dart';
import 'package:movies4u/view/widget/movie_cast_crew.dart';
import 'package:movies4u/view/widget/movie_keyword.dart';
import 'package:movies4u/view/widget/rating_result.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/sifi_movie_row.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:movies4u/view/widget/video_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';

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
  final apiName;
  final tag;
  final index;
  final movieId;
  MovieModel model;
  final double expandedHeight = 350.0;
  final image, movieName;

  _DetailsMovieScreenState(this.movieName, this.image, this.apiName, this.index,
      this.movieId, this.tag);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.movieDetails(movieId);
    model.movieCrewCast(movieId);
    model.fetchRecommendMovie(movieId);
    model.fetchSimilarMovie(movieId);
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
          return apiHandler(loading: _createUi(), response: jsonResult);
      },
    );
  }

  Widget _createUi({MovieDetailsRespo data}) {
//    print(' obj   :  ' + data.releaseDate);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _helperImage(data),
        ),
        CustomScrollView(
          slivers: <Widget>[
            _appBarView(),
            _contentSection(data),
          ],
        ),
      ],
    );
  }

  Widget _helperImage(MovieDetailsRespo data) {
    return Container(
      height: expandedHeight + 50,
      width: double.infinity,
      child: Hero(
          tag: tag,
          child: Container(child: getCacheImage(url:image, height: expandedHeight+50)
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

  Widget _contentSection(MovieDetailsRespo data) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [getContai(data)],
      ),
    );
  }

  Widget getContai(MovieDetailsRespo data) {
    return Container(
      width: double.infinity,
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
          SifiMovieRow(ApiConstant.MOVIE_IMAGES),
          MovieCastCrew(castCrew: StringConst.MOVIE_CAST, movieId: movieId),
          MovieCastCrew(castCrew: StringConst.MOVIE_CREW, movieId: movieId),
          VideoView('Trailer'),
          MovieKeyword('Keyword'),
          TrandingMovieRow(
              apiName: ApiConstant.RECOMMENDATIONS_MOVIE, movieId: movieId),
          TrandingMovieRow(
              apiName: ApiConstant.SIMILAR_MOVIES, movieId: movieId),
        ],
      ),
    );
  }

  Widget _contentTitle(MovieDetailsRespo movie) {
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
              RatingBar(
                itemSize: 12.0,
                initialRating: movie == null ? 0 : movie.voteAverage / 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: getBackgrountRate(movie == null ? 0 : movie.voteAverage),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
          SizedBox(height: 7),
          MovieTag(items: movie == null ? null : movie.genres),
          SizedBox(height: 10),
          _contentAbout(movie),
          SizedBox(height: 10),
          getTxtBlackColor(
              msg: 'Overview', fontSize: 18, fontWeight: FontWeight.bold),
          SizedBox(height: 7),
          if (movie != null)
            getTxtGreyColor(
                msg: movie.overview != null ? movie.overview : '',
                fontSize: 15,
                fontWeight: FontWeight.w400)
          else
            ShimmerView.getOverView(context)
        ],
      ),
    );
  }

  Widget _contentAbout(MovieDetailsRespo _dataMovie) {
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
              _contentDescriptionAbout('Release Date',
                  _dataMovie != null ? _dataMovie.releaseDate : null),
              _contentDescriptionAbout('Budget',
                  '\$${_dataMovie != null ? _dataMovie.budget : null}'),
              _contentDescriptionAbout('Revenue',
                  '\$${_dataMovie != null ? _dataMovie.revenue : null}'),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                width: 80,
                height: 125,
                child: getCacheImage(url:_dataMovie == null
                    ? image
                    : ApiConstant.IMAGE_POSTER +
                        _dataMovie.backdropPath.toString(), height: 125, width: 80)),
          ),
        ],
      ),
    );
  }

  Widget _contentDescriptionAbout(String title, String value) {
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
              Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Container(
                    width: 150,
                    height: 10,
                    color: Colors.white,
                  ))
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

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
import 'package:movies4u/utils/global_utility.dart';
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

  const DetailsMovieScreen(this.movieName, this.image, this.apiName, this.index,
      this.movieId, this.tag, {super.key});

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  late MovieModel model;
  late final double expandedHeight = 350.0;
  late SizingInformation sizeInfo;
  late Size size;
  final ScrollController scrollController = ScrollController();
  // final image, movieName;
  //  final apiName;
  //  final index;
  //  final movieId;
  //  final tag;

  // _DetailsMovieScreenState(this.movieName, this.image, this.apiName, this.index,
  //     this.movieId, this.tag);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.movieDetails(widget.movieId);
    model.movieCrewCast(widget.movieId);
    model.fetchRecommendMovie(widget.movieId, 1);
    model.fetchSimilarMovie(widget.movieId, 1);
    model.keywordList(widget.movieId);
    model.movieVideo(widget.movieId);
    model.movieImg(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel(model: model, child: apiResponse(context)));
  }

  Widget apiResponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieDetails;
        if (jsonResult.status == ApiStatus.success) {
          return _createUi(data: jsonResult.data);
        } else {
          return apiHandler(
              loading: _createUi(data: null), response: jsonResult);
        }
      },
    );
  }

  Widget _createUi({required MovieDetailsRespo? data}) {
//    print(' obj   :  ' + data.releaseDate);
    size = MediaQuery.of(context).size;
    return ResponsiveBuilder(builder: (context, sizeInf) {
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
            controller: scrollController,
            thumbVisibility: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
            radius: const Radius.circular(5),
            thickness: sizeInfo.deviceScreenType == DeviceScreenType.desktop?20:0,
            child: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                _appBarView(),
                _contentSection(data),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _helperImage(MovieDetailsRespo? data) {
    return SizedBox(
      height: expandedHeight + 50,
      width: size.width,
      child: Hero(
          tag: widget.tag,
          child: Container(
              child: getCacheImage(url: widget.image, height: expandedHeight + 50)
              // ApiConstant.IMAGE_ORIG_POSTER + data.posterPath.toString()),
              )),
    );
  }

  Widget _appBarView() {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(
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
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: expandedHeight - 50,
      snap: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
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
        color: ColorConst.whiteBgColor,
        borderRadius: const BorderRadius.only(
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
                child: Image.asset(AssetsConst.dividerImg)),
          ),
          SifiMovieRow(ApiConstant.movieImages, sizeInfo),
          MovieCastCrew(
              castCrew: StringConst.movieCast,
              sizeInfo: sizeInfo,
              movieId: widget.movieId),
          MovieCastCrew(
              castCrew: StringConst.movieCrew,
              sizeInfo: sizeInfo,
              movieId: widget.movieId),
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
                child: Image.asset(AssetsConst.dividerImg)),
          ),
          TrandingMovieRow(
              apiName: ApiConstant.recommendationsMovie,
              sizeInfo: sizeInfo,
              movieId: widget.movieId),
          TrandingMovieRow(
              apiName: ApiConstant.similarMovies,
              sizeInfo: sizeInfo,
              movieId: widget.movieId),
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
                    msg: widget.movieName, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              RatingResult(movie == null ? 0 : movie.voteAverage, 12.0),
              const SizedBox(width: 5),
              RatingBar.builder(
                itemSize: 12.0,
                initialRating: movie == null ? 0 : movie.voteAverage! / 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color:
                      getBackgroundRate(movie == null ? 0 : movie.voteAverage!),
                ),
                onRatingUpdate: (rating) {
                  printLog(tag: runtimeType.toString(),msg:"Rating : $rating");
                },
              )
            ],
          ),
          const SizedBox(height: 7),
          MovieTag(items: movie?.genres, sizes: sizeInfo),
          const SizedBox(height: 10),
          _contentAbout(movie),
          const SizedBox(height: 10),
          getTxtBlackColor(
              msg: 'Overview', fontSize: 18, fontWeight: FontWeight.bold),
          const SizedBox(height: 7),
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

  Widget _contentAbout(MovieDetailsRespo? dataMovie) {
    var relDate = "";
    var budget = "";
    var revenue = "";
    if (dataMovie != null) {
      try {
        var inputFormat = DateFormat("yyyy-MM-dd");
        DateTime date1 = inputFormat.parse(dataMovie.releaseDate!);
        relDate = '${date1.day}/${date1.month}/${date1.year}';
        budget = NumberFormat.simpleCurrency().format(dataMovie.budget);
        revenue = NumberFormat.simpleCurrency().format(dataMovie.revenue);
      } catch (exp) {
        printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:exp);
      }
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
                  'Status', dataMovie?.status),
              _contentDescriptionAbout('Duration',
                  '${dataMovie?.runtime} min'),
              _contentDescriptionAbout(
                  'Release Date', dataMovie != null ? relDate : null),
              _contentDescriptionAbout(
                  'Budget',
                  '${dataMovie != null ? dataMovie.budget == 0 ? ' N/A' : budget : null}'),
              _contentDescriptionAbout(
                  'Revenue',
                  '${dataMovie != null ? dataMovie.revenue == 0 ? ' N/A' : revenue : null}'),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
                width: 80,
                height: 125,
                child: getCacheImage(
                    url: dataMovie == null
                        ? widget.image
                        : ApiConstant.imagePoster +
                            dataMovie.backdropPath.toString(),
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
                msg: title,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
            const Text(' : '),
            if (value == null)
              Container(
                width: 150,
                height: 10,
                color: Colors.grey[300],
              )
            else
              getTxtAppColor(
                  msg: value,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

import 'package:movies4u/constant/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/home/now_playing_respo.dart';
import 'package:movies4u/data/person/person_movie_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/details/detail_movie.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/listing/movie_list_screen.dart';
import 'package:movies4u/view/widget/rating_result.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class TrandingMovieRow extends StatelessWidget {
  final apiName;
  final movieId;
  final sizeInfo;
  TrandingMovieRow({required this.apiName,required this.sizeInfo, this.movieId = 0});

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context)); //getTradingList(context);
  }

  Widget apiresponse(BuildContext context) {
    print("MovieId : $movieId");
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = getData(apiName, model);
        if (jsonResult.status == ApiStatus.COMPLETED)
          return getCount(jsonResult.data) > 0
              ? getMovieList(context, apiName, jsonResult.data)
              : Container();
        else
          return apiHandler(
              loading:  ShimmerView(
                  sizeInfo,
                  viewType: ShimmerView.VIEW_HORIZONTAL_MOVIE_LIST,
                   parentHeight:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:240,
                height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?320:185,
                width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?240:125,
                ),
              response: jsonResult);
        // return ShimmerView(
        //   sizeInfo,
        //   viewType: ShimmerView.VIEW_HORIZONTAL_MOVIE_LIST,
        // parentHeight:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:240,
        // height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?320:185,
        // width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?240:125,
        // );
      },
    );
  }

//  List<Result>
  Widget getMovieList(BuildContext context, String apiName, var jsonResult) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(
            context: context,
            apiName: apiName,
            movieId: movieId,
            isShowViewAll: getCount(jsonResult) > 8 ? true : false),
        SizedBox(height: 10),
        SizedBox(
          height:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:240.0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: getCount(jsonResult), //results.length,
            itemBuilder: (context, index) {
//              Result item = jsonResult[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: getView(context, apiName, jsonResult,sizeInfo, index),
              );
            },
          ),
        ),
      ],
    );
  }

  int getCount(jsonResult) {
    if (jsonResult is NowPlayingRespo)
      return jsonResult.results!.length;
    else if (apiName == StringConst.PERSON_MOVIE_CAST &&
        jsonResult is PersonMovieRespo)
      return jsonResult.cast!.length;
    else if (apiName == StringConst.PERSON_MOVIE_CREW &&
        jsonResult is PersonMovieRespo) return jsonResult.crew!.length;
    return 0;
  }

//  bool isShowViewAll(jsonResult) {
//    if (jsonResult is NowPlayingRespo)
//      return getCount(jsonResult) > 8 ? true : false;
//    else  if (apiName == StringConst.PERSON_MOVIE_CAST &&
//        jsonResult is PersonMovieRespo)
//      return false;
//    else if (apiName == StringConst.PERSON_MOVIE_CREW &&
//        jsonResult is PersonMovieRespo) return jsonResult.crew.length;
//      return false;
//    else
//      return true;
//  }

  Widget getView(BuildContext context, String apiName, jsonResult, SizingInformation sizeInfo, int index) {
    if (jsonResult is NowPlayingRespo) {
      NowPlayResult item = jsonResult.results![index];
      return getMovieItemRow(
          context: context,
          apiName: apiName,
          index: index,
          height:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?335:185,
          width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?240:125,
          id: item.id!,
          img: item.posterPath == null ? "" : item.posterPath!,
          name: item.originalTitle!,
          vote: item.voteAverage);
    } else if (apiName == StringConst.PERSON_MOVIE_CAST &&
        jsonResult is PersonMovieRespo) {
      PersonCast item = jsonResult.cast![index];
      return getMovieItemRow(
          context: context,
          apiName: apiName,
          index: index,
          height:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?335:185,
          width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?240:125,
          id: item.id!,
          img: item.posterPath == null ? "" : item.posterPath!,
          name: item.originalTitle!,
          vote: item.voteAverage);
    } else if (apiName == StringConst.PERSON_MOVIE_CREW &&
        jsonResult is PersonMovieRespo) {
      PersonCrew item = jsonResult.crew![index];
      return getMovieItemRow(
          context: context,
          apiName: apiName,
          index: index,
          height:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?335:185,
          width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?240:125,
          id: item.id!,
          img: item.posterPath == null ? "" : item.posterPath!,
          name: item.originalTitle!,
          vote: item.voteAverage);
    } else
      return Container();
  }
}

Widget getMovieItemRow(
    {required BuildContext context,
    String? apiName ,
    int? index ,
    double? height,
    double? width,
    int? id ,
    String? img ,
    String? name,
    var vote,
    Function? onTap}) {
  String tag = getTitle(apiName!) + img! + index.toString();
  return  Hero(
        tag: tag,
        child: Container(
          width: width,
          child: Column(
            children: <Widget>[
            SizedBox(
                    height: height,
                    child: ClipRRect(
                      child: Stack(
                        children: [
                          getCacheImage(
                              url:img.contains("http") ? img : ApiConstant.IMAGE_POSTER + img.toString(), height: height!),
                          Positioned.fill(
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      splashColor: ColorConst.SPLASH_COLOR,
                                      onTap: () {
                                        if (onTap != null) {
                                          onTap();
                                        } else
                                          navigationPush(
                                              context,
                                              DetailsMovieScreen(
                                                  name, ApiConstant.IMAGE_POSTER+img,apiName, index, id, tag));
                                      }))),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              if(name!=null)
              Align(
                  alignment: Alignment.topLeft,
                  child: getTxtBlackColor(
                      msg: name,
                      maxLines: 1,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start)),
              if(vote!=null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
//                  getTxtBlackColor(
//                      msg: item.vote_average.toString(),
//                      fontSize: 12,
//                      fontWeight: FontWeight.bold),
                  RatingResult(vote, 12.0),
                  SizedBox(width: 5),
                  RatingBar.builder(
                    itemSize: 12.0,
                    initialRating: double.parse((vote / 2).toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: getBackgrountRate(double.parse(vote.toString())),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      );
}

Color getBackgrountRate(double rate) {
  if (rate < 5.0) {
    return Colors.red;
  } else if (rate < 6.8) {
    return Colors.yellow;
  } else if (rate < 7.3) {
    return Colors.blue;
  } else {
    return Colors.green;
  }
}

Widget getHeading(
    {required BuildContext context,
    String apiName = "",
    int movieId = 0,
    bool isShowViewAll = true}) {
  String titleTag = getTitle(apiName) + "_Heading_" + apiName;
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Hero(
          tag: titleTag,
          child: getTxtBlackColor(
              msg: getTitle(apiName),
              fontSize: 19,
              fontWeight: FontWeight.w700),
        ),
        if (isShowViewAll)
          InkWell(
            onTap: () {
              navigationPush(
                  context, MovieListScreen(apiName: apiName, movieId: movieId));
            },
            child: getTxtColor(
                msg: StringConst.VIEW_ALL,
                txtColor: ColorConst.APP_COLOR,
                fontWeight: FontWeight.w800),
          )
      ],
    ),
  );
}

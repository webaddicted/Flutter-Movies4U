import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/movie_img_respo.dart';
import 'package:movies4u/data/home/now_playing_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/details/detail_movie.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/widget/full_image.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class SifiMovieRow extends StatelessWidget {
  final apiName;
  final sizeInfo;
  SifiMovieRow(this.apiName, this.sizeInfo);

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context)); //getTradingList(context);
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = getData(apiName, model);
        if (jsonResult.status == ApiStatus.COMPLETED)
          return getCount(jsonResult.data) > 0
              ? getTradingList(context, jsonResult.data)
              : Container();
        else
          return apiHandler(
              loading: Container(
                  height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:170,
                  child: ShimmerView(
                      sizeInfo,height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:170,viewType: ShimmerView.VIEW_CASOSAL),
                ),
              response: jsonResult);
        // return Container(
        //   height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:170,
        //   child: ShimmerView(
        //       sizeInfo,height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?380:170,viewType: ShimmerView.VIEW_CASOSAL),
        // );
      },
    );
  }

  Widget getTradingList(BuildContext context, var jsonResult) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(
            context: context,
            apiName: apiName,
            isShowViewAll: isShowViewAll(jsonResult)),
        SizedBox(height: 10),
        SizedBox(
          height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?405:190.0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: getCount(jsonResult),
            itemBuilder: (context, index) {
              return getView(context, index, jsonResult);
            },
          ),
        ),
      ],
    );
  }

  int getCount(results) {
    if (results is NowPlayingRespo)
      return results.results!.length;
    else if (apiName == StringConst.IMAGES && results is MovieImgRespo)
      return results.profiles!.length;
    else if (results is MovieImgRespo)
      return results.backdrops!.length;
    else
      return 0;
  }

  bool isShowViewAll(results) {
    if (results is NowPlayingRespo)
      return getCount(results) > 8 ? true : false;
    else if (apiName == StringConst.IMAGES && results is MovieImgRespo)
      return false;
    else if (results is MovieImgRespo)
      return false;
    else
      return true;
  }

  Widget getView(BuildContext context, int index, jsonResult) {
    if (jsonResult is MovieImgRespo) {
      Backdrops item;
      if (jsonResult.profiles != null && jsonResult.profiles!.length > 0)
        item = jsonResult.profiles![index];
      else
        item = jsonResult.backdrops![index];
      String tag = getTitle(apiName) + item.filePath! != null
          ? item.filePath!
          : '' + index.toString();

     return Padding(
         padding: const EdgeInsets.all(4.0),
         child: getMovieItemRow(
            context: context,
            apiName: apiName,
            index: index,
             height:  sizeInfo.deviceScreenType == DeviceScreenType.desktop?335:180,
             width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?240:125,
            id: 256,
            img:(sizeInfo.deviceScreenType == DeviceScreenType.desktop?ApiConstant.IMAGE_ORIG_POSTER:ApiConstant.IMAGE_POSTER) +  item.filePath!,
           onTap: ()=> navigationPush(
               context,
               FullImage(
                   jsonResult.profiles! != null && jsonResult.profiles!.length > 0
                       ? jsonResult.profiles!
                       : jsonResult.backdrops!,
                   index,
                   tag))),
     );
      // return getLargeItem(
      //     context: context,
      //     img:(sizeInfo.deviceScreenType == DeviceScreenType.desktop?ApiConstant.IMAGE_ORIG_POSTER:ApiConstant.IMAGE_POSTER) +  item.filePath,
      //     screenSpace: 80,
      //     sizeInfo:sizeInfo,
      //     tag: tag,
      //     onTap: () => navigationPush(
      //         context,
      //         FullImage(
      //             jsonResult.profiles != null && jsonResult.profiles.length > 0
      //                 ? jsonResult.profiles
      //                 : jsonResult.backdrops,
      //             index,
      //             tag)));
    } else if (jsonResult is NowPlayingRespo) {
      NowPlayResult item = jsonResult.results![index];
      String tag = getTitle(apiName) + item.posterPath! + index.toString();
      String img = ApiConstant.IMAGE_POSTER + item.posterPath!;
      return getLargeItem(
          context: context,
          img:(sizeInfo.deviceScreenType == DeviceScreenType.desktop?ApiConstant.IMAGE_ORIG_POSTER:ApiConstant.IMAGE_POSTER)  + item.backdropPath!,
          name: item.originalTitle!,
          screenSpace: 80,
          sizeInfo:sizeInfo,
          tag: tag,
          onTap: () => navigationPush(
              context,
              DetailsMovieScreen(
                  item.originalTitle, img, apiName, index, item.id, tag)));
    } else
      return Container(child: getTxt(msg: StringConst.NO_DATA_FOUND));
  }

//  getMovieImage(BuildContext context, MovieImgRespo results) {
//    return Column(
//      children: <Widget>[
//        SizedBox(height: 10),
//        getHeading(context: context, apiName: apiName, isShowViewAll: false),
//        SizedBox(height: 10),
//        SizedBox(
//          height: 190.0,
//          child: ListView.builder(
//            shrinkWrap: true,
//            scrollDirection: Axis.horizontal,
//            itemCount: results.backdrops.length,
//            itemBuilder: (context, index) {
//              var item = results.backdrops[index];
//              String tag = getTitle(apiName) + item.filePath + index.toString();
//              return getLargeItem(
//                  context: context,
//                  img: ApiConstant.IMAGE_POSTER + item.filePath,
//                  tag: tag,
//                  onTap: () => navigationPush(
//                      context, FullImage(results.backdrops, index, tag)));
//            },
//          ),
//        ),
//      ],
//    );
//  }
}

Widget getLargeItem(
    {required BuildContext context,
    String img="",
    String name = "",
    String tag = "",
    double screenSpace = 0,
    required Function onTap, sizeInfo}) {
  final size = MediaQuery.of(context).size;
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: tag,
            child: Container(
              height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?365:150,
              width: size.width - screenSpace,
              child: ClipRRect(
                child: Stack(children: [
                  Image.network(
                    img,
                    fit: BoxFit.cover,
                    width: size.width - screenSpace,
                  ),
                  Positioned.fill(
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: ColorConst.SPLASH_COLOR,
                            onTap: () => onTap(),
                          ))),
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 5),
          if (name != null)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: getTxtBlackColor(
                    msg: name, fontSize: 15, fontWeight: FontWeight.w700)),
        ],
      ));
}

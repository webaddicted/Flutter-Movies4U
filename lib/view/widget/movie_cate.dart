import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/home/movie_cat_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/listing/movie_list_screen.dart';
import 'package:movies4u/view/widget/movie_cast_crew.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieCate extends StatelessWidget {
  SizingInformation sizeInfo;

  MovieCate({required this.sizeInfo});

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieCat;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return getCate(context, jsonResult.data!.genres!, sizeInfo);
        else
          return apiHandler(
              loading: ShimmerView(
                sizeInfo,
                viewType: ShimmerView.VIEW_HORI_PERSON,
                parentHeight:
                    sizeInfo.deviceScreenType == DeviceScreenType.desktop
                        ? 250
                        : 150.0,
                height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 250
                    : 100,
                width: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 200
                    : 110,
              ),
              response: jsonResult);
        // return ShimmerView(
        //   sizeInfo,
        //   viewType: ShimmerView.VIEW_HORI_PERSON,
        //   parentHeight: sizeInfo.deviceScreenType == DeviceScreenType.desktop?250:150.0,
        //   height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?250:100,
        //   width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?200:110,
        // );
      },
    );
  }

  Widget getCate(
      BuildContext context, List<Genres> genres, SizingInformation sizeInfo) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: ApiConstant.GENRES_LIST),
        SizedBox(height: 10),
        Container(
          height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
              ? 300
              : 150.0,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (BuildContext context, int index) {
                var item = genres[index];
                return Container(
                    padding: EdgeInsets.only(
                        top: sizeInfo.deviceScreenType ==
                                DeviceScreenType.desktop
                            ? 20
                            : 10.0),
                    width: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                        ? 250
                        : 100.0,
                    child: castCrewItem(
                        id: item.id!,
                        tag: 'Generic Item' + index.toString(),
                        name: item.name!,
                        image: getCategoryMovie()[index],
                        sizeInfo: sizeInfo,
                        onTap: (int id) => navigationPush(
                            context,
                            MovieListScreen(
                                apiName: StringConst.MOVIE_CATEGORY,
                                dynamicList: item.name!,
                                movieId: item.id!))));

                // return getCatRow(context,index, genres[index], sizeInfo);
              }),
        ),
      ],
    );
  }
}

Widget getCatRow(
    BuildContext context, int index, Genres item, SizingInformation sizeInfo) {
  return Container(
    padding: EdgeInsets.all(
        sizeInfo.deviceScreenType == DeviceScreenType.desktop ? 2 : 2.0),
    width: sizeInfo.deviceScreenType == DeviceScreenType.desktop ? 250 : 100.0,
    child: Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(
                sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 200
                    : 100.0)),
            child: Stack(
              children: [
                loadCircleCacheImg(
                    getCategoryMovie()[index],
                    sizeInfo.deviceScreenType == DeviceScreenType.desktop
                        ? 200
                        : 100),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: ColorConst.SPLASH_COLOR,
                            onTap: () {
                              navigationPush(
                                  context,
                                  MovieListScreen(
                                      apiName: StringConst.MOVIE_CATEGORY,
                                      dynamicList: item.name!,
                                      movieId: item.id!));
                            }))),
              ],
            ),
          ),
          getTxtBlackColor(msg: item.name!, fontWeight: FontWeight.w700)
        ],
      ),
    ),
  );
}

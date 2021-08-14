import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/credits_crew_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/person/person_detail.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieCastCrew extends StatelessWidget {
  String castCrew;
  int movieId;
  SizingInformation sizeInfo;
  MovieCastCrew({this.castCrew = "", required this.sizeInfo, this.movieId = 0});

  @override
  Widget build(BuildContext context) {
//    return Container(color: Colors.black,height: 250,);
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieCrew;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return trandingPerson(context, jsonResult.data!);
        else
          return apiHandler(
              loading: ShimmerView(
                sizeInfo,
                viewType: ShimmerView.VIEW_HORI_PERSON,
                parentHeight: 150,
                height: 100,
                width: 110,
              ),
              response: jsonResult);
      },
    );
  }

  Widget trandingPerson(BuildContext context, CreditsCrewRespo data) {
    return Container(
      child:  Column(
        children: <Widget>[
          SizedBox(height: 10),
          getHeading(context: context, apiName: castCrew, movieId: movieId),
          SizedBox(height: 8),
          getPersonItem(context, data)
        ],
      )
    );
  }

  Widget getPersonItem(BuildContext context, CreditsCrewRespo results) {
    return Container(
      height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?300:150.0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: castCrew == StringConst.MOVIE_CAST
            ? results.cast!.length
            : results.crew!.length,
        itemBuilder: (context, index) {
          String? image = castCrew == StringConst.MOVIE_CAST
              ? results.cast![index].profilePath
              : results.crew![index].profilePath;
          String? name = castCrew == StringConst.MOVIE_CAST
              ? results.cast![index].name
              : results.crew![index].name;
          String? chatactor = castCrew == StringConst.MOVIE_CAST
              ? results.cast![index].character
              : results.crew![index].job;
          int? id = castCrew == StringConst.MOVIE_CAST
              ? results.cast![index].id
              : results.crew![index].id;
          var tag = castCrew + 'cast_view' + index.toString();
          print("Path $image");
          return castCrewItem(
              id: id ,
              tag: tag ,
              name: name ,
              image: image ,
              job: chatactor ,
              sizeInfo: sizeInfo,
              onTap: (int id) => navigationPush(
                  context,
                  PersonDetail(
                      id: id,
                      name: name,
                      imgPath: ApiConstant.IMAGE_POSTER + image.toString(),
                      tag: tag)));
        },
      ),
    );
  }
}

Widget castCrewItem(
    {int? id,
     String? name ,
    String? image ,
    String? job ,
    String? tag,
      required Function onTap, required SizingInformation sizeInfo}) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?280:100.0,
    child: InkWell(
      onTap: () {
        onTap(id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image == null
              ? Hero(
                  tag: tag!,
                  child: Container(
                    width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?200:80.0,
                    height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?200:80.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: ColorConst.APP_COLOR),
                    child: Icon(
                      Icons.person_pin,
                      color: Colors.white,
                    ),
                  ),
                )
              : Hero(
                  tag: tag.toString(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(sizeInfo.deviceScreenType == DeviceScreenType.desktop?220:80.0)),
                      child: Stack(
                        children: [
                          loadCircleCacheImg(job==null&&image.contains("http")?image:ApiConstant.IMAGE_POSTER + image, sizeInfo.deviceScreenType == DeviceScreenType.desktop?220:80),
                         Positioned.fill(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          splashColor: ColorConst.SPLASH_COLOR,
                                          onTap: () {
                                            onTap(id);
                                          }))),
                        ],
                      ),
                    ),
                ),
          SizedBox(height: 5.0),
          getTxtBlackColor(
              msg: name!,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              textAlign: TextAlign.center),
          if(job!=null)
          SizedBox(height: 3.0),
          if(job!=null)
          getTxtBlackColor(
              msg: job,
              fontSize: 12,
              maxLines: 1,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

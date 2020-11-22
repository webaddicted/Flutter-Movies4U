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
import 'package:scoped_model/scoped_model.dart';

class MovieCastCrew extends StatelessWidget {
  String castCrew;
  int movieId;

  MovieCastCrew({this.castCrew, this.movieId});

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
          return trandingPerson(context, jsonResult.data);
        else
          return apiHandler(
              loading: ShimmerView(
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
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: castCrew, movieId: movieId),
        SizedBox(height: 8),
        getPersonItem(context, data)
      ],
    );
  }

  Widget getPersonItem(BuildContext context, CreditsCrewRespo results) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castCrew == StringConst.MOVIE_CAST
            ? results.cast.length
            : results.crew.length,
        itemBuilder: (context, index) {
          String image = castCrew == StringConst.MOVIE_CAST
              ? results.cast[index].profilePath
              : results.crew[index].profilePath;
          String name = castCrew == StringConst.MOVIE_CAST
              ? results.cast[index].name
              : results.crew[index].name;
          String chatactor = castCrew == StringConst.MOVIE_CAST
              ? results.cast[index].character
              : results.crew[index].job;
          int id = castCrew == StringConst.MOVIE_CAST
              ? results.cast[index].id
              : results.crew[index].id;
          var tag = castCrew + 'cast_view' + index.toString();
          return castCrewItem(
              id: id,
              tag: tag,
              name: name,
              image: image,
              job: chatactor,
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
    {int id,
    String name,
    String image,
    String job,
    String tag,
    Function onTap}) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    width: 100.0,
    child: GestureDetector(
      onTap: () {
        onTap(id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image == null
              ? Hero(
                  tag: tag,
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: ColorConst.APP_COLOR),
                    child: Icon(
                      Icons.person_pin,
                      color: Colors.white,
                    ),
                  ),
                )
              : Hero(
                  tag: tag,
                  child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(ApiConstant.IMAGE_POSTER + image)),
                      )),
                ),
          SizedBox(height: 5.0),
          getTxtBlackColor(
              msg: name,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              textAlign: TextAlign.center),
          SizedBox(height: 3.0),
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

import 'package:movies4u/constant/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/keyword_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/listing/movie_list_screen.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieKeyword extends StatelessWidget {
  String castCrew;
  SizingInformation sizeInfo;
  MovieKeyword(this.castCrew, this.sizeInfo);

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieKeyword;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return jsonResult.data!.keywords!.length > 0
              ? movieKeyword(context, jsonResult.data!)
              : Container();
        else
          return apiHandler(loading:ShimmerView.movieDetailsTag(),response: jsonResult);
      },
    );
  }

  Widget movieKeyword(BuildContext context, KeywordRespo data) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: castCrew, isShowViewAll: false),
        SizedBox(height: 8),
        getKeywordItem(context, data)
      ],
    );
  }

  Widget getKeywordItem(BuildContext context, KeywordRespo data) {
    return SizedBox(
      child:  Wrap(
          direction: Axis.horizontal,
          children: getKeywordListings(context, data.keywords!)!,
      ),
    );
  }

  getKeywordListings(
      BuildContext context, List<Keywords> keywords) {
    List listings = <Widget>[];
    for (int i = 0; i < keywords.length; i++) {
      listings.add(
        Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 5,bottom: 5),
          child: InkWell(
            onTap: () => navigationPush(
                context,
                MovieListScreen(
                    apiName: StringConst.MOVIES_KEYWORDS,
                    dynamicList: keywords[i].name!,
                    movieId: keywords[i].id!)),
            child: Chip(
              elevation: 3.0,
              backgroundColor: ColorConst.WHITE_COLOR,
              label: Text(keywords[i].name!),
            ),
          ),
        ),
      );
    }
    return listings;
  }
}

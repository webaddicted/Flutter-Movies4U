import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constant/string_const.dart';
import 'package:flutter_movie_app/data/details/keyword_respo.dart';
import 'package:flutter_movie_app/model/movie_model.dart';
import 'package:flutter_movie_app/utils/apiutils/api_response.dart';
import 'package:flutter_movie_app/utils/widgethelper/widget_helper.dart';
import 'package:flutter_movie_app/view/details/movie_list_screen.dart';
import 'package:flutter_movie_app/view/widget/shimmer_view.dart';
import 'package:flutter_movie_app/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieKeyword extends StatelessWidget {
  String castCrew;

  MovieKeyword(this.castCrew);

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieKeyword;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return jsonResult.data.keywords.length > 0
              ? trandingPerson(context, jsonResult.data)
              : Container();
        else
          return apiHandler(loading: ShimmerView.movieDetailsTag(),response: jsonResult);
      },
    );
  }

  Widget trandingPerson(BuildContext context, KeywordRespo data) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: castCrew, isShowViewAll: false),
        SizedBox(height: 8),
        getPersonItem(context, data)
      ],
    );
  }

  Widget getPersonItem(BuildContext context, KeywordRespo data) {
    return SizedBox(
      child: Expanded(
        child: Wrap(
          direction: Axis.horizontal,
          children: getKeywordListings(context, data.keywords),
        ),
      ),
    );
  }

  List<Widget> getKeywordListings(
      BuildContext context, List<Keywords> keywords) {
    List listings = List<Widget>();
    for (int i = 0; i < keywords.length; i++) {
      listings.add(
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: InkWell(
            onTap: () => navigationPush(
                context,
                MovieListScreen(
                    apiName: StringConst.MOVIES_KEYWORDS,
                    dynamicList: keywords[i].name,
                    movieId: keywords[i].id)),
            child: Chip(
              elevation: 3.0,
              backgroundColor: Colors.white,
              label: Text(keywords[i].name),
            ),
          ),
        ),
      );
    }
    return listings;
  }
}

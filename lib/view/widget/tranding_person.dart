import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/person/tranding_person_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/person/person_detail.dart';
import 'package:movies4u/view/widget/movie_cast_crew.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class TrandingPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.trandingPersonRespo;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return jsonResult.data.results.length > 0
              ? trandingPerson(context, jsonResult.data.results)
              : Container();
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

  Widget trandingPerson(BuildContext context, List<Results> results) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(
            context: context, apiName: StringConst.TRANDING_PERSON_OF_WEEK),
        SizedBox(height: 8),
        getPersonItem(context, results)
      ],
    );
  }

  Widget getPersonItem(BuildContext context, List<Results> persons) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: persons.length,
        itemBuilder: (context, index) {
          var item = persons[index];
          return Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 100.0,
              child: castCrewItem(
                  id: item.id,
                  tag: 'tranding person' + index.toString(),
                  name: item.name,
                  image: item.profilePath,
                  job: item.knownForDepartment,
                  onTap: (int id) => navigationPush(
                      context,
                      PersonDetail(
                          id: item.id,
                          name: item.name,
                          imgPath: ApiConstant.IMAGE_POSTER + item.profilePath,
                          tag: 'tranding person' + index.toString()))));
        },
      ),
    );
  }
}
